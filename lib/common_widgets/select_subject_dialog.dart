import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:diaryschool/models/subject.dart' show Subject;
import 'package:diaryschool/provider/SubjectProvider.dart' show SubjectProvider;
import 'package:diaryschool/screens/subjects/subject_dialog.dart' show SubjectDialog;
import 'package:flutter/material.dart' show AlertDialog, BuildContext, FlatButton, Icon, IconButton, Icons, Key, ListTile, ListView, Navigator, Row, Spacer, StatelessWidget, Text, Theme, Widget, showDialog;
import 'package:provider/provider.dart';

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
            I18n.of(context).selectSubject,
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
                  _list[index].title,
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
