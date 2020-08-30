import 'package:diaryschool/generated/i18n.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/teachers/teacher_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryschool/utilities/TextStyles.dart';

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
            icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
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
          child: Text(I18n.of(context).close).button(),
        ),
      ],
    );
  }
}
