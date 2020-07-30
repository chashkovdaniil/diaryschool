import 'dart:developer';

import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class TeacherDialog extends StatefulWidget {
  final int index;
  final Teacher teacher;
  TeacherDialog({
    Key key,
    this.index,
    @required this.teacher,
  }) : super(key: key);

  @override
  _TeacherDialogState createState() => _TeacherDialogState();
}

class _TeacherDialogState extends State<TeacherDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Добавить учителя'),
      content: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TextFormField(
            initialValue: widget.teacher.name,
            decoration: InputDecoration(hintText: 'Имя'),
            onChanged: (value) {
              setState(() {
                widget.teacher.name = value;
              });
            },
          ),
          TextFormField(
            initialValue: widget.teacher.surname,
            decoration: InputDecoration(hintText: 'Фамилия'),
            onChanged: (value) {
              setState(() {
                widget.teacher.surname = value;
              });
            },
          ),
          TextFormField(
            initialValue: widget.teacher.middleName,
            decoration: InputDecoration(hintText: 'Отчество'),
            onChanged: (value) {
              setState(() {
                widget.teacher.middleName = value;
              });
            },
          ),
          TextFormField(
            initialValue: widget.teacher.email,
            decoration: InputDecoration(hintText: 'Email'),
            onChanged: (value) {
              setState(() {
                widget.teacher.email = value;
              });
            },
          ),
          TextFormField(
            initialValue: widget.teacher.phone == null
                ? ''
                : widget.teacher.phone.toString(),
            decoration: InputDecoration(hintText: 'Телефон'),
            onChanged: (value) {
              setState(() {
                widget.teacher.phone = int.parse(value);
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Отмена'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () {
            Provider.of<TeacherProvider>(context, listen: false).add(
              widget.teacher,
              index: widget.index,
            );
            Navigator.of(context).pop();
          },
          child: Text('Сохранить'.toUpperCase()),
        ),
      ],
    );
  }
}
