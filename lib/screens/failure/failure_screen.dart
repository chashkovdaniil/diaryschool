import 'package:diaryschool/common_widgets/card_widget.dart';
// import 'package:diaryschool/data/models/timetable.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/screens/tasks/tasks_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class FailureScreen extends StatefulWidget {
  FailureScreen({Key key}) : super(key: key);
  static String id = '/failureScreen';
  @override
  _FailureScreenState createState() => _FailureScreenState();
}

class _FailureScreenState extends State<FailureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Долги'),
        actions: <Widget>[
          // IconButton(
          //   onPressed: () =>
          //       Navigator.of(context).pushReplacementNamed(TasksScreen.id),
          //   icon: Icon(Icons.swap_horiz),
          //   tooltip: 'Долги',
          // ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        children: <Widget>[
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
            ),
            label: Text(
              'Добавить',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          CardWidget(
            homework: Homework(
              date: DateTime(2020, 06, 28),
              subject: 1,
              content: 'Test',
              deadline: DateTime(2020, 07, 30),
              grade: '5',
              isDone: false,
            ),
            filter: {
              'teacher': false,
              'route': false,
              'deadline': true,
              'time': false,
            },
          )
        ],
      ),
    );
  }
}
