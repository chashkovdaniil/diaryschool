import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/teachers/teacher_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectDialog extends StatefulWidget {
  Subject subject;
  int index;
  SubjectDialog({
    Key key,
    this.subject,
    this.index,
  }) : super(key: key);

  @override
  _SubjectDialogState createState() => _SubjectDialogState();
}

class _SubjectDialogState extends State<SubjectDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Предмет'),
      content: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TextFormField(
            initialValue: widget.subject.title,
            decoration: InputDecoration(hintText: 'Название'),
            onChanged: (value) {
              setState(() {
                widget.subject.title = value;
              });
            },
          ),
          TextFormField(
            initialValue: widget.subject.map,
            decoration: InputDecoration(hintText: 'Кабинет или аудитория'),
            onChanged: (value) {
              setState(() {
                widget.subject.map = value;
              });
            },
          ),
          FlatButton(
            onPressed: () async {
              widget.subject.teacher = await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Row(
                    children: <Widget>[
                      Text(
                        'Выбрать учителя',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return TeacherDialog(teacher: Teacher());
                            },
                          );
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  content: Consumer<TeacherProvider>(
                    builder: (context, data, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ListTile(
                          dense: true,
                          onTap: () => Navigator.of(context).pop(index),
                          title: Text(
                            data.values[index].toString(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        itemCount: data.values.length,
                      );
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Закрыть'.toUpperCase()),
                    ),
                  ],
                ),
              );
              setState(() {});
            },
            child: Text(
              widget.subject.teacher == null
                  ? 'Указать учителя'
                  : Provider.of<TeacherProvider>(context).values[widget.subject.teacher].toString(),
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Отмена'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () {
            Provider.of<SubjectProvider>(
              context,
              listen: false,
            ).put(
              widget.subject,
              index: widget.index,
            );
            return Navigator.of(context).pop();
          },
          child: Text('Сохранить'.toUpperCase()),
        ),
      ],
    );
  }
}
