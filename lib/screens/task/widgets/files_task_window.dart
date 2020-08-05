import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class FilesTaskWindow extends StatefulWidget {
  FilesTaskWindow({Key key}) : super(key: key);
  @override
  _FilesTaskWindowState createState() => _FilesTaskWindowState();
}

class _FilesTaskWindowState extends State<FilesTaskWindow> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Изображения'),
      actions: <Widget>[
        FlatButton(
          child: Text('Закрыть'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Добавить'),
          onPressed: () {},
        ),
      ],
      content: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
