import 'dart:developer';

import 'package:edum/common_widgets/select_subject_dialog.dart';
import 'package:edum/generated/i18n.dart';
import 'package:edum/models/homework.dart';
import 'package:edum/provider/HomeworkProvider.dart';
import 'package:edum/provider/SettingsProvider.dart';
import 'package:edum/provider/SubjectProvider.dart';
import 'package:edum/screens/task/widgets/grade_field.dart';
import 'package:edum/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

// TODO: сделать подсказки

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
  Homework _homework;
  OverlayEntry _overlayEntry;

  @override
  void initState() {
    _homework = Homework.fromMap(widget.homework);
    log(_homework.isDone.toString());
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задание'),
      ),
      //TODO: сделать валидацию
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SubjectField(
              context: context,
              homework: _homework,
              initialValue: _homework.subject,
              validator: (val) {
                if (val == null && _homework.subject == null) {
                  return I18n.of(context).fillField;
                }
                return null;
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
                    log('yes');
                  } else {
                    log('yes');
                    _homework.date = _date;
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${I18n.of(context).date}:',
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
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return I18n.of(context).fillField;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: I18n.of(context).enterTask,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                  initialValue: _homework.content,
                  maxLines: null,
                  maxLengthEnforced: true,
                  onChanged: (value) {
                    _homework.content = value;
                  },
                ),
              ),
            ),
            BottomAppBar(
              elevation: 0,
              child: Row(
                children: <Widget>[
                  // TODO: add files button
                  // IconButton(
                  //   icon: Icon(Icons.collections),
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (ctx) => FilesTaskWindow(),
                  //     );
                  //   },
                  // ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      String _grade = await showDialog(
                        context: context,
                        builder: (ctx) => GradeField(grade: _homework.grade),
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
                    icon: _homework.grade == null
                        ? const Icon(Icons.star)
                        : Text(
                            _homework.grade,
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                  ),
                  IconButton(
                    onPressed: () async {
                      _homework.deadline = await showDatePicker(
                        context: context,
                        lastDate: DateTime(2100),
                        firstDate: DateTime(2010),
                        initialDate: _homework.deadline ?? DateTime.now(),
                      );
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.timer,
                      color: _homework.deadline == null
                          ? null
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      _homework.isDone = !_homework.isDone;
                    }),
                    icon: Icon(
                      Icons.done,
                      color: _homework.isDone
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Provider.of<HomeworkProvider>(
                          context,
                          listen: false,
                        ).put(_homework);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      I18n.of(context).save,
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 10),
                  // TODO: add share button
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.share),
                  // ),
                ],
              ),
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
            I18n.of(context).tipTask1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.star),
              Expanded(
                child: Text(
                  I18n.of(context).tipTask2,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.timer),
              Expanded(
                child: Text(
                  I18n.of(context).tipTask3,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.done),
              Expanded(
                child: Text(
                  I18n.of(context).tipTask4,
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
                            ? I18n.of(context).close
                            : I18n.of(context).save,
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

class SubjectField extends FormField<int> {
  SubjectField({
    Key key,
    BuildContext context,
    int initialValue,
    FormFieldValidator validator,
    @required Homework homework,
  }) : super(
          key: key,
          validator: validator,
          builder: (FormFieldState<int> state) {
            return InkWell(
              onTap: () async {
                int _subject = await showDialog(
                  context: context,
                  builder: (context) => SelectSubjectDialog(
                    context: context,
                  ),
                );

                state.didChange(_subject);
                if (_subject != null) {
                  homework.subject = _subject;
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Column(
                  children: [
                    state.hasError
                        ? Text(
                            state.errorText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.red),
                          )
                        : const SizedBox.shrink(),
                    Row(
                      children: <Widget>[
                        Text(
                          '${I18n.of(context).subject}:',
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
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    Provider.of<SubjectProvider>(context)
                                            .values
                                            .isEmpty
                                        ? I18n.of(context).addSubject
                                        : Provider.of<SubjectProvider>(context)
                                            .values[homework.subject ?? 0]
                                            .title,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    maxLines: 1,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
}
