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
    List<Teacher> _list = context.watch<TeacherProvider>().values;
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
      content: _list.isEmpty
          ? Text('Список пуст')
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
          child: Text('Закрыть'.toUpperCase()),
        ),
      ],
    );
  }
}
