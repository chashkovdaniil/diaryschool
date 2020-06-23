import 'package:diaryschool/screens/task/args.dart';
import 'package:diaryschool/screens/task/widgets/files_task_window.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key key}) : super(key: key);
  static String id = "/taskScreen";

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<String> files = [
    '/src/1.img',
    '/src/2.img',
    '/src/3.img',
  ];

  @override
  Widget build(BuildContext context) {
    final TaskScreenArgs args =
        ModalRoute.of(context).settings.arguments as TaskScreenArgs;
    return Scaffold(
      appBar: AppBar(
        title: Text('Математика'),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.collections),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => FilesTaskWindow(),
                );
              },
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => GradeTaskWindow(),
                );
              },
              icon: Icon(Icons.star_border),
            ),
            IconButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  lastDate: DateTime(2100),
                  firstDate: DateTime(2010),
                  initialDate: DateTime.now(),
                );
              },
              icon: Icon(Icons.timer),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.done),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
            ),
          ],
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Введите задание',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            initialValue: '',
            maxLines: null,
            maxLengthEnforced: true,
          ),
        ),
      ),
    );
  }
}

class GradeTaskWindow extends StatefulWidget {
  GradeTaskWindow({Key key}) : super(key: key);
  @override
  _GradeTaskWindowState createState() => _GradeTaskWindowState();
}

class _GradeTaskWindowState extends State<GradeTaskWindow> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Оценка'),
      content: TextFormField(
        initialValue: '0',
        keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Закрыть'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Готово'),
          onPressed: () {},
        ),
      ],
    );
  }
}
