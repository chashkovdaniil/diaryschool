import 'dart:async';
import 'dart:developer';

import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/screens/task/widgets/grade_field.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/TextStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryschool/screens/task/widgets/SubjectField.dart';
import 'package:diaryschool/utilities/Extensions.dart';

class TaskScreen extends StatefulWidget {
  final Map<String, dynamic> homework;
  TaskScreen(
    this.homework, {
    Key key,
  }) : super(key: key);
  static String id = '/taskScreen';

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'taskPage');
  bool isOpen = false;
  Homework _homework;
  FocusNode focusNode;
  StreamController<bool> _keyboardController;
  Stream<bool> _keyboardBroadcast;

  @override
  void initState() {
    _keyboardController = StreamController();
    _keyboardBroadcast = _keyboardController.stream.asBroadcastStream();
    _homework = Homework.fromMap(widget.homework);
    super.initState();
  }

  @override
  void dispose() {
    _keyboardController.close();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    focusNode = FocusNode();
    ThemeData theme = Theme.of(context);

    _keyboardBroadcast.listen((_isOpen) => isOpen = _isOpen);

    return WillPopScope(
      onWillPop: checkOpennessKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('task')),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildAboveTaskField(context, theme),
              buildTaskField(),
              buildUnderTaskField(theme, context),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<bool> buildUnderTaskField(
      ThemeData theme, BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _keyboardBroadcast,
      builder: (_, snapshot) {
        return Column(
          children: [
            if (!snapshot.data) buildButtonsBar(theme, context),
            const SizedBox(height: 8),
            if (!snapshot.data) buildSaveButton(context) else buildDoneButton(),
          ],
        );
      },
    );
  }

  Widget buildDoneButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Button(
          tr('done'),
          onTap: closeKeyboard,
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget buildButtonsBar(ThemeData theme, BuildContext context) {
    var redButtons = [
      if (_homework.grade != null) ...[
        FlatButton(
          color: theme.primaryColor,
          child: Row(
            children: [
              Text('${tr('grade')} ${_homework.grade}').buttonReverse(),
              const SizedBox(width: 8),
              Icon(
                Icons.remove_circle,
                color: theme.colorScheme.background,
              ),
            ],
          ),
          onPressed: () {
            setState(() => _homework.grade = null);
          },
        ),
        const SizedBox(width: 10),
      ],
      if (_homework.isDone) ...[
        FlatButton(
          color: theme.primaryColor,
          child: Row(
            children: [
              Text(tr('taskСompleted')).buttonReverse(),
              const SizedBox(width: 8),
              Icon(
                Icons.remove_circle,
                color: theme.colorScheme.background,
              ),
            ],
          ),
          onPressed: () {
            setState(() => _homework.isDone = !_homework.isDone);
          },
        ),
        const SizedBox(width: 10),
      ],
      if (_homework.deadline != null && !_homework.isDone) ...[
        FlatButton(
          color: theme.primaryColor,
          child: Row(
            children: [
              Text('${_homework.deadline.dmyStr}').buttonReverse(),
              const SizedBox(width: 8),
              Icon(
                Icons.remove_circle,
                color: theme.colorScheme.background,
              ),
            ],
          ),
          onPressed: () {
            setState(() => _homework.deadline = null);
          },
        ),
        const SizedBox(width: 10),
      ],
    ];
    var transparentButtons = [
      if (_homework.grade == null) ...[
        FlatButton(
          onPressed: () async {
            String _grade = await showDialog(
              context: context,
              builder: (ctx) => GradeField(grade: _homework.grade),
            );
            if (_grade == '0' || _grade == '') {
              _homework.grade = null;
            } else if (_grade != '0' && _grade != '' && _grade != null) {
              _homework.grade = _grade;
            }
            setState(() {});
          },
          child: Text(tr('toRate')).button(),
        ),
        const SizedBox(width: 10),
      ],
      if (_homework.deadline == null && !_homework.isDone) ...[
        FlatButton(
          onPressed: () async {
            _homework.deadline = await showDatePicker(
              context: context,
              lastDate: DateTime(2100),
              firstDate: DateTime(2010),
              initialDate: _homework.deadline ?? DateTime.now(),
            );
            setState(() {});
          },
          child: Text(tr('setDeadline')).button(),
        ),
        const SizedBox(width: 10),
      ],
      if (!_homework.isDone) ...[
        FlatButton(
          onPressed: () => setState(() {
            _homework.isDone = !_homework.isDone;
          }),
          child: Text("${tr('taskСompleted')}?").button(),
        ),
        const SizedBox(width: 10),
      ],
    ];
    return SizedBox(
      height: 50,
      child: ListView(
        padding: const EdgeInsets.only(left: 10),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: redButtons + transparentButtons,
      ),
    );
  }

  Widget buildSaveButton(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Button(
          tr('save'),
          onTap: () {
            if (_formKey.currentState.validate()) {
              Provider.of<HomeworkProvider>(
                context,
                listen: false,
              ).put(_homework);
              Navigator.of(context).pop();
            }
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget buildTaskField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: TextFormField(
          focusNode: focusNode,
          validator: (val) {
            assert(val != null);
            return (val.isEmpty) ? tr('fillField') : null;
          },
          decoration: InputDecoration(
            hintText: tr('enterTask'),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          initialValue: _homework.content,
          maxLines: null,
          maxLengthEnforced: true,
          onTap: () => _keyboardController.add(true),
          onChanged: (value) => _homework.content = value,
        ),
      ),
    );
  }

  Widget buildAboveTaskField(BuildContext context, ThemeData theme) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _keyboardBroadcast,
      builder: (_, snapshot) {
        return snapshot.data
            ? const SizedBox.shrink()
            : Column(
                children: <Widget>[
                  buildSubjectField(context),
                  const Divider(
                    height: 0,
                  ),
                  buildDateSelector(context, theme),
                  const Divider(
                    height: 0,
                  ),
                ],
              );
      },
    );
  }

  Widget buildDateSelector(BuildContext context, ThemeData theme) {
    return InkWell(
      onTap: () async {
        DateTime _date = await showDatePicker(
          context: context,
          initialDate: _homework.date,
          firstDate: DateTime(
            2010,
            01,
            22,
          ),
          lastDate: DateTime(
            2030,
            01,
            22,
          ),
        );
        setState(() {
          if (_date == null) {
            _homework.date = DateTime.now();
            return;
          }
          _homework.date = _date;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Row(
          children: <Widget>[
            Text(
              '${tr('date')}:',
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                ),
                child: Text(
                  '${_homework.date.day}.'
                  '${_homework.date.month}.'
                  '${_homework.date.year}',
                  style: theme.textTheme.subtitle1.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubjectField(BuildContext context) {
    return SubjectField(
      context: context,
      homework: _homework,
      initialValue: _homework.subject,
      validator: (val) {
        return (val == null && _homework.subject == null)
            ? tr('fillField')
            : null;
      },
    );
  }

  Future<bool> checkOpennessKeyboard() async {
    if (isOpen) {
      closeKeyboard();
      return false;
    }
    return true;
  }

  void closeKeyboard() {
    focusNode.unfocus();
    focusNode.consumeKeyboardToken();
    _keyboardController.add(false);
  }
}
