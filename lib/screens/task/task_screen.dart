import 'dart:developer';

import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/screens/task/widgets/grade_field.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/TextStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  bool isEdit = false;
  Homework _homework;
  OverlayEntry _overlayEntry;
  FocusNode focusNode;

  @override
  void initState() {
    _homework = Homework.fromMap(widget.homework);
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (Provider.of<SettingsProvider>(context).getFirstRunTaskPage) {
      _overlayEntry = firstRun(context);
      SchedulerBinding.instance.addPostFrameCallback((timestap) {
        Overlay.of(context).insert(_overlayEntry);
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('task')),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            if (!isEdit) ...[
              SubjectField(
                context: context,
                homework: _homework,
                initialValue: _homework.subject,
                validator: (val) {
                  return (val == null && _homework.subject == null)
                      ? tr('fillField')
                      : null;
                },
              ),
              const Divider(
                height: 0,
              ),
              InkWell(
                onTap: () async {
                  DateTime _date = await showDatePicker(
                    context: context,
                    initialDate: _homework.date,
                    firstDate: DateTime(
                      2000,
                      01,
                      22,
                    ),
                    lastDate: DateTime(
                      2100,
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
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 0,
              ),
            ],
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: TextFormField(
                  focusNode: focusNode,
                  validator: (val) {
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
                  onTap: () {
                    setState(() {
                      isEdit = true;
                      focusNode.nextFocus();
                    });
                    // focusNode.requestFocus(focusNode);
                  },
                  onChanged: (value) {
                    _homework.content = value;
                  },
                ),
              ),
            ),
            (isEdit)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Spacer(),
                      Button(
                        tr('done'),
                        onTap: () {
                          focusNode.unfocus();
                          setState(() {
                            isEdit = false;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView(
                          padding: const EdgeInsets.only(left: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                                if (_homework.grade != null) ...[
                                  FlatButton(
                                    color: Theme.of(context).primaryColor,
                                    child: Row(
                                      children: [
                                        Text('Оценка ${_homework.grade}')
                                            .buttonReverse(),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.remove_circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      _homework.grade = null;
                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                if (_homework.isDone) ...[
                                  FlatButton(
                                    color: Theme.of(context).primaryColor,
                                    child: Row(
                                      children: [
                                        Text('Задание выполнено')
                                            .buttonReverse(),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.remove_circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      _homework.isDone = !_homework.isDone;
                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                if (_homework.deadline != null &&
                                    !_homework.isDone) ...[
                                  FlatButton(
                                    color: Theme.of(context).primaryColor,
                                    child: Row(
                                      children: [
                                        Text('${_homework.deadline.dmyStr}')
                                            .buttonReverse(),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.remove_circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      _homework.deadline = null;
                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ] +
                              [
                                if (_homework.grade == null) ...[
                                  FlatButton(
                                    onPressed: () async {
                                      String _grade = await showDialog(
                                        context: context,
                                        builder: (ctx) =>
                                            GradeField(grade: _homework.grade),
                                      );
                                      if (_grade == '0' || _grade == '') {
                                        _homework.grade = null;
                                      } else if (_grade != '0' &&
                                          _grade != '' &&
                                          _grade != null) {
                                        _homework.grade = _grade;
                                      }
                                      setState(() {});
                                    },
                                    child: Text('Поставить оценку').button(),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                if (_homework.deadline == null &&
                                    !_homework.isDone) ...[
                                  FlatButton(
                                    onPressed: () async {
                                      _homework.deadline = await showDatePicker(
                                        context: context,
                                        lastDate: DateTime(2100),
                                        firstDate: DateTime(2010),
                                        initialDate: _homework.deadline ??
                                            DateTime.now(),
                                      );
                                      setState(() {});
                                    },
                                    child: Text('Установить дедлайн').button(),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                if (!_homework.isDone) ...[
                                  FlatButton(
                                    onPressed: () => setState(() {
                                      _homework.isDone = !_homework.isDone;
                                    }),
                                    child: Text('Задание выполнено').button(),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Spacer(),
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
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  OverlayEntry firstRun(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
        List<Widget> tips = [
          Text(
            tr('tipTask1'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.star),
              Expanded(
                child: Text(
                  tr('tipTask2'),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.timer),
              Expanded(
                child: Text(
                  tr('tipTask3'),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.done),
              Expanded(
                child: Text(
                  tr('tipTask4'),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ];
        int currentTip = 0;
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    tips[currentTip],
                    FlatButton(
                      onPressed: () {
                        if (currentTip == tips.length - 1) {
                          Provider.of<SettingsProvider>(
                            context,
                            listen: false,
                          ).setFirstRunTaskPage();
                          _overlayEntry.remove();
                          return;
                        }
                        setState(() {
                          currentTip += 1;
                        });
                      },
                      child: Text(
                        (currentTip == tips.length - 1)
                            ? tr('close')
                            : tr('save'),
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
