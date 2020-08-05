import 'dart:developer';

import 'package:diaryschool/common_widgets/select_subject_dialog.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/screens/task/args.dart';
import 'package:diaryschool/screens/task/widgets/files_task_window.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  Homework _homework;
  final int index;
  TaskScreen({
    Key key,
    Homework homework,
    this.index,
  }) : super(key: key) {
    _homework = index == null
        ? Homework(
            date: DateTime.now(),
          )
        : homework;
  }
  static String id = "/taskScreen";

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<String> files = [
    '/src/1.img',
    '/src/2.img',
    '/src/3.img',
  ];

  int idSubject = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задание'),
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () async {
              int _subject = await showDialog(
                context: context,
                builder: (context) => SelectSubjectDialog(
                  context: context,
                ),
              );
              setState(() {
                widget._homework.subject = _subject;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: Row(
                children: <Widget>[
                  Text(
                    'Предмет:',
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
                          Consumer<SubjectProvider>(
                            builder: (context, data, child) {
                              return Text(
                                data.values[widget._homework.subject ?? 0]
                                    .title,
                                style: Theme.of(context).textTheme.headline6,
                              );
                            },
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
            ),
          ),
          const Divider(
            height: 0,
          ),
          InkWell(
            onTap: () async {
              DateTime _date = await showDatePicker(
                context: context,
                initialDate: widget._homework.date,
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
                widget._homework.date = _date ?? DateTime.now();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: Row(
                children: <Widget>[
                  Text(
                    'Дата:',
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
                        '${widget._homework.date.day}.'
                        '${widget._homework.date.month}.'
                        '${widget._homework.date.year}',
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
                decoration: InputDecoration(
                  hintText: 'Введите задание',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
                initialValue: widget._homework.content,
                maxLines: null,
                maxLengthEnforced: true,
                onChanged: (value) {
                  widget._homework.content = value;
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
                      builder: (ctx) => GradeTaskWindow(),
                    );
                    setState(() {
                      widget._homework.grade =
                          (_grade == '0' || _grade == null) ? null : _grade;
                    });
                  },
                  icon: widget._homework.grade == null
                      ? Icon(Icons.star_border)
                      : Text(
                          widget._homework.grade,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                ),
                IconButton(
                  onPressed: () async {
                    widget._homework.deadline = await showDatePicker(
                      context: context,
                      lastDate: DateTime(2100),
                      firstDate: DateTime(2010),
                      initialDate: widget._homework.deadline ?? DateTime.now(),
                    );
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.timer,
                    color: widget._homework.deadline == null
                        ? null
                        : Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() {
                    widget._homework.isDone = !widget._homework.isDone;
                  }),
                  icon: Icon(
                    Icons.done,
                    color: widget._homework.isDone
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    // TODO: Сделать валидацию
                    if (widget._homework.content != null) {
                      Provider.of<HomeworkProvider>(
                        context,
                        listen: false,
                      ).put(
                        widget._homework,
                        index: widget.index,
                      );
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Сохранить',
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: Theme.of(context).accentColor,
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
    );
  }
}

class GradeTaskWindow extends StatefulWidget {
  String grade;
  GradeTaskWindow({Key key, this.grade}) : super(key: key);
  @override
  _GradeTaskWindowState createState() => _GradeTaskWindowState();
}

class _GradeTaskWindowState extends State<GradeTaskWindow> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Оценка'),
      content: TextFormField(
        initialValue: widget.grade ?? '0',
        keyboardType: TextInputType.number,
        onChanged: (value) => widget.grade = value,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Закрыть'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Готово'),
          onPressed: () => Navigator.of(context).pop(widget.grade),
        ),
      ],
    );
  }
}
