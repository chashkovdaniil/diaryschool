import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final DateTime date;
  final Map<String, bool> filter;
  FilterDialog({Key key, this.date, this.filter}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    DateTime _newDate;

    return AlertDialog(
      title: const Text('Фильтр'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              if (_newDate != null) {
                print(_newDate.day);
              }
              _newDate = await showDatePicker(
                context: context,
                initialDate: widget.date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (_newDate != null) {
                setState(() {});
                print('yeah');
              }
            },
            child: _newDate == null
                ? const Text('Выбрать дату')
                : Text('${_newDate.day}.' +
                    '${_newDate.month}.' +
                    '${_newDate.year}'),
          ),
          ListTile(
            title: const Text('Учитель'),
            trailing: Checkbox(
              value: widget.filter['teacher'],
              onChanged: (val) {
                setState(() {
                  widget.filter['teacher'] = val;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Время'),
            trailing: Checkbox(
              value: widget.filter['time'],
              onChanged: (val) {
                setState(() {
                  widget.filter['time'] = val;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Дедлайн'),
            trailing: Checkbox(
              value: widget.filter['deadline'],
              onChanged: (val) {
                setState(() {
                  widget.filter['deadline'] = val;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Путь'),
            trailing: Checkbox(
              value: widget.filter['route'],
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
          child: const Text('Отмена'),
        ),
        FlatButton(
          onPressed: () {},
          child: const Text('Применить'),
        ),
      ],
    );
  }
}
