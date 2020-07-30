import 'dart:async';

import 'package:diaryschool/screens/failure/failure_screen.dart';
import 'package:diaryschool/screens/grades/grades_screen.dart';
import 'package:diaryschool/screens/home/home_screen.dart';
import 'package:diaryschool/screens/timetable/timetable_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);
  static String id = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    GradesScreen(),
    FailureScreen(),
    TimetableScreen(),
    // SettingsScreen(),
  ];
  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: const Text('Главная'),
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.trending_up,
          size: 24,
        ),
        title: const Text('Оценки')),
    BottomNavigationBarItem(
      icon: Icon(Icons.done_all),
      title: const Text('Долги'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: const Text('Расписание'),
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   title: const Text('Настройки'),
    // ),
  ];

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexController = StreamController<int>.broadcast();

  @override
  void dispose() {
    indexController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: screens,
        ),
      ),
      bottomNavigationBar: StreamBuilder<Object>(
        initialData: 0,
        stream: indexController.stream,
        builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
          int cIndex = snapshot.data as int;
          return Container(
            child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: false,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: Theme.of(context).colorScheme.onSurface,
              backgroundColor: Colors.transparent,
              currentIndex: cIndex,
              onTap: (int value) {
                indexController.add(value);
                pageController.jumpToPage(value);
              },
              items: bottomNavigationBarItems,
            ),
          );
        },
      ),
    );
  }
}
