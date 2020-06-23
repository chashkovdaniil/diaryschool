import 'dart:async';

import 'package:diaryschool/screens/home/home_screen.dart';
import 'package:diaryschool/screens/timetable/timetable_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/linearicons.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);
  static String id = "/";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    const Center(
      child: Text('Grades'),
    ),
    const Center(
      child: Text('Not done'),
    ),
    // const Center(child: Text("qqq")),
    TimetableScreen(),
    const Center(
      child: Text('Profile'),
    )
  ];
  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Linearicons.home),
      title: const Text(''),
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Linearicons.chart_bars,
          size: 24,
        ),
        title: const Text('')),
    BottomNavigationBarItem(
      icon: Icon(Linearicons.checkmark_cicle),
      title: const Text(''),
    ),
    BottomNavigationBarItem(
      icon: Icon(Linearicons.calendar_full),
      title: const Text(''),
    ),
    BottomNavigationBarItem(
      icon: Icon(Linearicons.user),
      title: const Text(''),
    ),
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
              showSelectedLabels: false,
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
