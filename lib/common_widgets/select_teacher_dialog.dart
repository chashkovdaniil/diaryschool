import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:diaryschool/models/teacher.dart' show Teacher;
import 'package:diaryschool/provider/TeacherProvider.dart' show TeacherProvider;
import 'package:diaryschool/screens/teachers/teacher_dialog.dart' show TeacherDialog;
import 'package:flutter/material.dart' show AlertDialog, BuildContext, FlatButton, Icon, IconButton, Icons, Key, ListTile, ListView, Navigator, Row, Spacer, StatelessWidget, Text, Theme, Widget, showDialog;
import 'package:provider/provider.dart';

class SelectTeacherDialog extends StatelessWidget {
  final BuildContext context;
  const SelectTeacherDialog({
    Key key,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Teacher> _list = context.watch<TeacherProvider>().values;
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Text(
            I18n.of(context).selectTeacher,
            style: Theme.of(context)
                .textTheme
                .subtitle1
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
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      content: _list.isEmpty
          ? Text(I18n.of(context).emptyList)
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                dense: true,
                onTap: () => Navigator.of(context).pop(index),
                title: Text(
                  _list[index].toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              itemCount: _list.length,
            ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(I18n.of(context).close.toUpperCase()),
        ),
      ],
    );
  }
}
