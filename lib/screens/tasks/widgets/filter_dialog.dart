import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDialog extends StatefulWidget {
  final Map<String, bool> filter;
  FilterDialog({
    Key key,
    @required this.filter,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AlertDialog(
      title: Text(tr('filter')),
      content: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text(tr('teacher')),
            trailing: Checkbox(
              value: widget.filter['teacher'],
              activeColor: theme.primaryColor,
              onChanged: (val) {
                widget.filter['teacher'] = val;
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(tr('deadline')),
            trailing: Checkbox(
              value: widget.filter['deadline'],
              activeColor: theme.primaryColor,
              onChanged: (val) {
                setState(() {
                  widget.filter['deadline'] = val;
                });
              },
            ),
          ),
          // ListTile(
          //   title: const Text('Показывать только невыполненные'),
          //   trailing: Checkbox(
          //     value: widget.filter['deadline'],
          //     activeColor: theme.primaryColor,
          //     onChanged: (val) {
          //       setState(() {
          //         widget.filter['deadline'] = val;
          //       });
          //     },
          //   ),
          // ),
          ListTile(
            title: Text(tr('path')),
            trailing: Checkbox(
              value: widget.filter['route'],
              activeColor: theme.primaryColor,
              onChanged: (val) {
                setState(() {
                  widget.filter['route'] = val;
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(tr('cancel')),
        ),
        FlatButton(
          onPressed: () {
            context.read<SettingsProvider>().setFilter(widget.filter);
            Navigator.pop(context);
          },
          child: Text(tr('save')),
        ),
      ],
    );
  }
}
