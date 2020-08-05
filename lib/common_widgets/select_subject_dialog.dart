import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/screens/subjects/subject_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectSubjectDialog extends StatelessWidget {
  final BuildContext context;
  const SelectSubjectDialog({
    Key key,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Text(
            'Выбрать предмет',
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
                  return SubjectDialog(subject: Subject());
                },
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      content: Consumer<SubjectProvider>(
        builder: (context, data, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
              dense: true,
              onTap: () => Navigator.of(context).pop(index),
              title: Text(
                data.values[index].title,
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
