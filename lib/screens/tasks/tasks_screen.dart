import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:diaryschool/common_widgets/card_widget.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
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
  Map<String, bool> _filter;
  DateTime currentDate = DateTime.now();
  int currentWeekday;
  final List<String> daysOfWeek = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  final DateTime firstDayOfCurrentDate =
      DateTime.now().add(Duration(days: -DateTime.now().weekday + 1));

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
    _filter = Provider.of<SettingsProvider>(context).filter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Задания'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterDialog(
                  filter: _filter,
                ),
              );
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          _homeworks.isNotEmpty
              ? CarouselSlider.builder(
                  itemCount: _homeworks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardWidget(
                      key: ValueKey(
                          _homeworks[index].date.millisecondsSinceEpoch),
                      filter: _filter,
                      homework: _homeworks[index],
                    );
                  },
                  options: CarouselOptions(
                    height: 260,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    disableCenter: false,
                  ),
                )
              : const Center(
                  child: Text('Нет заданий'),
                ),
                const Spacer(),
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: Text('Добавить'),
          ),
          Container(
            color: Theme.of(context).colorScheme.background,
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
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: _homeworks.length,
          //   itemBuilder: (context, index) {
          //     return CardWidget(
          //       key: ValueKey(_homeworks[index].date.millisecondsSinceEpoch),
          //       filter: _filter,
          //       homework: _homeworks[index],
          //       index: index,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
