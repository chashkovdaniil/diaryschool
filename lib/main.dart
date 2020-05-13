import 'dart:async';

import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:diaryschool/pages/timetable_page.dart';


void main() {
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(DiarySchoolApp());
}

class DiarySchoolApp extends StatefulWidget {
  DiarySchoolApp({Key key}) : super(key: key);

  @override
  _DiarySchoolAppState createState() => _DiarySchoolAppState();
}

class _DiarySchoolAppState extends State<DiarySchoolApp> {
  final List<Widget> pages = [
    const Center(
      child: Text('Home'),
    ),
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
      icon: Icon(Icons.home), title: const Text('')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.trending_up), title: const Text('')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.check_circle_outline), title: const Text('')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today), title: const Text('')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle), title: const Text('')
    )
  ];

  PageController pageController = PageController(initialPage: 3);
  StreamController<int> indexController = StreamController<int>.broadcast();


  @override
  void dispose() {
    indexController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дневник',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: pages,
          ),
          bottomNavigationBar: StreamBuilder<Object>(
            initialData: 3,
            stream: indexController.stream,
            builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
              int cIndex = snapshot.data as int;
              return BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: selectedItemColorOnBNB,
                unselectedItemColor: unselectedItemColorOnBNB ,
                backgroundColor: Colors.transparent,
                currentIndex: cIndex,
                onTap: (int value) {
                  indexController.add(value);
                  pageController.jumpToPage(value);
                },
                items: bottomNavigationBarItems
              );
            },
          ),
        ),
      ),
    );
  }
}