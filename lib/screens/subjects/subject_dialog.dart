import 'package:diaryschool/common_widgets/select_teacher_dialog.dart';
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
                builder: (ctx) => SelectTeacherDialog(context: ctx),
              );
              setState(() {});
            },
            child: Text(
              widget.subject.teacher == null
                  ? 'Указать учителя'
                  : Provider.of<TeacherProvider>(context)
                      .values[widget.subject.teacher]
                      .toString(),
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
            // TODO: Сделать валидацию
            if (widget.subject.teacher != null) {
              Provider.of<SubjectProvider>(
                context,
                listen: false,
              ).put(
                widget.subject,
                index: widget.index,
              );
            }
            return Navigator.of(context).pop();
          },
          child: Text('Сохранить'.toUpperCase()),
        ),
      ],
    );
  }
}
