import 'dart:developer';

import 'package:diaryschool/common_widgets/card_widget.dart';
import 'package:diaryschool/common_widgets/custom_material_button.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/screens/tasks/widgets/filter_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({Key key}) : super(key: key);
  static String id = '/tasksScreen';
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<String> daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
  DateTime currentDate = DateTime.now();
  int currentWeekday;
  final DateTime firstDayOfCurrentDate =
      DateTime.now().add(Duration(days: -DateTime.now().weekday + 1));
  final Map<String, bool> filter = {
    'teacher': true,
    'route': true,
    'deadline': true,
    'time': false,
  };

  @override
  void initState() {
    currentWeekday = currentDate.weekday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Homework> _homeworks =
        context.watch<HomeworkProvider>().values.where((element) {
      if (element.date.year == currentDate.year &&
          element.date.month == currentDate.month &&
          element.date.day == currentDate.day) {
        return true;
      }
      return false;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Задания'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterDialog(
                  filter: filter,
                ),
              );
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
                top: kDefaultPadding + 10,
                bottom: 5,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${daysOfWeek[currentDate.weekday - 1]} - ${currentDate.day}',
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          DateTime _date = await showDatePicker(
                            context: context,
                            initialDate: currentDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (_date != null) currentDate = _date;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Slider.adaptive(
                    min: 1,
                    max: 7,
                    divisions: 6,
                    label: daysOfWeek[currentDate.weekday - 1],
                    value: currentDate.weekday + .0,
                    onChanged: (value) {
                      setState(() {
                        currentDate = currentDate.add(
                          Duration(
                            days: -(currentDate.weekday - value.round()),
                          ),
                        );
                        log(currentDate.toString());
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _homeworks.length,
              itemBuilder: (context, index) {
                return CardWidget(
                  key: ValueKey(_homeworks[index].date.millisecondsSinceEpoch),
                  filter: filter,
                  homework: _homeworks[index],
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
