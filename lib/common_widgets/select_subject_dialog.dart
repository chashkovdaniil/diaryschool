import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/screens/subjects/subject_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryschool/utilities/TextStyles.dart';

class SelectSubjectDialog extends StatelessWidget {
  final BuildContext context;
  const SelectSubjectDialog({
    Key key,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Subject> _list = context.watch<SubjectProvider>().values;
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Text(
            tr('selectSubject'),
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
                  return SubjectDialog(subject: Subject());
                },
              );
            },
            icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      content: _list.isEmpty
          ? Text(tr('emptyList'))
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                dense: true,
                onTap: () => Navigator.of(context).pop(index),
                title: Text(
                  _list[index].title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              itemCount: _list.length,
            ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('close')).button(),
        ),
      ],
    );
  }
}
