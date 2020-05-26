import 'dart:async';

import 'package:diaryschool/pages/home_page.dart';
import 'package:diaryschool/pages/timetable_page.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/linearicons.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  static String id = "/";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages = [
    HomePage(),
    const Center(
      child: Text('Grades'),
    ),
    const Center(
      child: Text('Not done'),
    ),
    // const Center(child: Text("qqq")),
    TimetablePage(),
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: pages,
        ),
        bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexController.stream,
          builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
            int cIndex = snapshot.data as int;
            return Container(
              // decoration: BoxDecoration(
              //   border: Border(
              //     top: BorderSide(
              //       width: 1,
              //       color: Color(0xffdfe3e4)
              //     ),
              //   ),
              // ),
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: kSelectedItemColorOnBNB,
                unselectedItemColor: kUnselectedItemColorOnBNB,
                backgroundColor: kBackgroundColorBodies,
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
      ),
    );
  }
}
