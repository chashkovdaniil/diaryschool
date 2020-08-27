import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:diaryschool/models/homework.dart' show Homework;
import 'package:diaryschool/provider/HomeworkProvider.dart' show HomeworkProvider;
import 'package:diaryschool/provider/SubjectProvider.dart' show SubjectProvider;
import 'package:diaryschool/screens/task/task_screen.dart' show TaskScreen;
import 'package:diaryschool/screens/tasks/tasks_screen.dart' show TasksScreen;
import 'package:diaryschool/utilities/constants.dart' show kBorderRadius, kDefaultPadding, kDefaultShadow;
import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart' show AppBar, BoxDecoration, BuildContext, Center, EdgeInsets, Icon, IconButton, Icons, Ink, Key, ListTile, ListView, MaterialPageRoute, Navigator, Padding, RoundedRectangleBorder, Scaffold, State, StatefulWidget, Text, Theme, Widget;
import 'package:provider/provider.dart';

class FailureScreen extends StatefulWidget {
  FailureScreen({Key key}) : super(key: key);
  static String id = '/failureScreen';
  @override
  _FailureScreenState createState() => _FailureScreenState();
}

class _FailureScreenState extends State<FailureScreen> {
  List<Homework> _failedTasks = [];

  @override
  Widget build(BuildContext context) {
    _failedTasks = context.watch<HomeworkProvider>().values.where((element) {
      return !element.isDone ? true : false;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).failure),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => TasksScreen(),
              ),
            ),
            icon: const Icon(Icons.swap_horiz),
            tooltip: I18n.of(context).tasksNav,
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: _failedTasks.isEmpty
          ? Center(
            child: Text(I18n.of(context).noTasks),
          )
          : ListView.builder(
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
                        '${context.watch<SubjectProvider>().subject(_failedTasks[index].subject).title}',
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
