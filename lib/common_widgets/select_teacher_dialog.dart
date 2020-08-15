import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/teachers/teacher_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectTeacherDialog extends StatelessWidget {
  final BuildContext context;
  const SelectTeacherDialog({
    Key key,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Text(
            'Выбрать учителя',
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
    );
  }
}
