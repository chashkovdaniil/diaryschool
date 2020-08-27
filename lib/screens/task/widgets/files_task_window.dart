import 'package:flutter/material.dart' show AlertDialog, BuildContext, Colors, Container, FlatButton, GridView, Key, Navigator, SliverGridDelegateWithFixedCrossAxisCount, State, StatefulWidget, Text, Widget;

class FilesTaskWindow extends StatefulWidget {
  FilesTaskWindow({Key key}) : super(key: key);
  @override
  _FilesTaskWindowState createState() => _FilesTaskWindowState();
}

class _FilesTaskWindowState extends State<FilesTaskWindow> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Изображения'),
      actions: <Widget>[
        FlatButton(
          child: const Text('Закрыть'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: const Text('Добавить'),
          onPressed: () {},
        ),
      ],
      content: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 28,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blueGrey,
            child: Text(index.toString()),
          );
        },
      ),
    );
  }
}
