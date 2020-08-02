import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final Map<String, bool> filter;
  FilterDialog({Key key, this.filter}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text('Фильтр'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
