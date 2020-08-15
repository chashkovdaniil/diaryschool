import 'dart:async';

import 'package:diaryschool/screens/grades/grades_screen.dart';
import 'package:diaryschool/screens/home/home_screen.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/screens/tasks/tasks_screen.dart';
import 'package:diaryschool/screens/timetable/timetable_page.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);
  static String id = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreen = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(debugLabel: 'Home'),
    GlobalKey<NavigatorState>(debugLabel: 'Grades'),
    GlobalKey<NavigatorState>(debugLabel: 'Tasks'),
    GlobalKey<NavigatorState>(debugLabel: 'Timetable'),
  ];
  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Главная'),
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.trending_up,
        size: 24,
      ),
      title: Text('Оценки'),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.format_list_bulleted),
      title: Text('Уроки'),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text('Расписание'),
    ),
  ];
  Widget navWidget({
    @required final int index,
    @required final Widget child,
  }) =>
      WillPopScope(
        child: child,
        onWillPop: () async {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
            return false;
          }
          if (_navigatorKeys[index].currentState.canPop()) {
            _navigatorKeys[index].currentState.pop();
            return false;
          }
          return true;
        },
      );

  List<Widget> _screens;

  @override
  void initState() {
    _screens = [
      navWidget(
        index: 0,
        child: HomeScreen(),
      ),
      navWidget(
        index: 1,
        child: GradesScreen(),
      ),
      navWidget(
        index: 2,
        child: TasksScreen(),
      ),
      navWidget(
        index: 3,
        child: TimetablePage(),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentScreen,
          children: _screens,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context).pushNamed(TaskScreen.id),
      //   elevation: 0,
      //   child: Icon(
      //     Icons.add,
      //     color: Theme.of(context).accentColor,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Colors.transparent,
        currentIndex: _currentScreen,
        onTap: (int value) {
          setState(() {
            _currentScreen = value;
          });
        },
        items: bottomNavigationBarItems,
      ),
    );
  }
}
