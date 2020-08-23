import 'package:edum/common_widgets/card_widget.dart';
// import 'package:edum/data/models/timetable.dart';
import 'package:edum/models/homework.dart';
import 'package:edum/provider/HomeworkProvider.dart';
import 'package:edum/provider/SettingsProvider.dart';
import 'package:edum/provider/SubjectProvider.dart';
import 'package:edum/screens/task/task_screen.dart';
import 'package:edum/screens/tasks/tasks_screen.dart';
import 'package:edum/utilities/constants.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FailureScreen extends StatefulWidget {
  FailureScreen({Key key}) : super(key: key);
  static String id = '/failureScreen';
  @override
  _FailureScreenState createState() => _FailureScreenState();
}

class _FailureScreenState extends State<FailureScreen> {
  List<Homework> _failedTasks = [];
  Map<String, bool> _filter;

  @override
  Widget build(BuildContext context) {
    _failedTasks = context.watch<HomeworkProvider>().values.where((element) {
      return !element.isDone ? true : false;
    }).toList();
    _filter = context.watch<SettingsProvider>().filter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Долги'),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => TasksScreen(),
              ),
            ),
            icon: Icon(Icons.swap_horiz),
            tooltip: 'Задания',
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        itemCount: _failedTasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: kDefaultShadow,
                borderRadius: kBorderRadius,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TaskScreen(
                        _failedTasks[index].toMap(),
                      ),
                    ),
                  );
                },
                title: Text(
                  '${_failedTasks[index].date.day}.'
                  '${_failedTasks[index].date.month}.'
                  '${_failedTasks[index].date.year} - '
                  '${context.watch<SubjectProvider>().values[_failedTasks[index].subject].title}',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                subtitle: Text(
                  '${_failedTasks[index].content}',
                  maxLines: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: kBorderRadius,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
