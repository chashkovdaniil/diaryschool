import 'package:diaryschool/generated/i18n.dart';
import 'package:diaryschool/provider/SettingsProvider.dart';
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
    return AlertDialog(
      title: Text(I18n.of(context).filter),
      content: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text(I18n.of(context).teacher),
            trailing: Checkbox(
              value: widget.filter['teacher'],
              activeColor: Theme.of(context).primaryColor,
              onChanged: (val) {
                widget.filter['teacher'] = val;
                setState(() {});
              },
            ),
          ),
          // ListTile(
          //   title: const Text('Время'),
          //   trailing: Checkbox(
          //     value:  widget.filter['time'],
          //     activeColor: Theme.of(context).primaryColor,
          //     onChanged: (val) {
          //       setState(() {
          //          widget.filter['time'] = val;
          //       });
          //     },
          //   ),
          // ),
          ListTile(
            title: Text(I18n.of(context).deadline),
            trailing: Checkbox(
              value: widget.filter['deadline'],
              activeColor: Theme.of(context).primaryColor,
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
          //     activeColor: Theme.of(context).primaryColor,
          //     onChanged: (val) {
          //       setState(() {
          //         widget.filter['deadline'] = val;
          //       });
          //     },
          //   ),
          // ),
          ListTile(
            title: Text(I18n.of(context).path),
            trailing: Checkbox(
              value: widget.filter['route'],
              activeColor: Theme.of(context).primaryColor,
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
          child: Text(I18n.of(context).cancel),
        ),
        FlatButton(
          onPressed: () {
            context.read<SettingsProvider>().setFilter(widget.filter);
            Navigator.pop(context);
          },
          child: Text(I18n.of(context).save),
        ),
      ],
    );
  }
}
