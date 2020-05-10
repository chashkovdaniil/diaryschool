import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import './pages/home.dart';


void main() {
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(DiarySchoolApp());
}

class DiarySchoolApp extends StatefulWidget {
  @override
  _DiarySchoolAppState createState() => _DiarySchoolAppState();
}

class _DiarySchoolAppState extends State<DiarySchoolApp> {
  @override
  void dispose() {
    indexController.close();
    super.dispose();
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexController = StreamController<int>.broadcast();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дневник',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home:
      SafeArea(
        child: Scaffold(
          body: PageView(
            onPageChanged: (index) {
              indexController.add(index);
            },
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              HomePage(),
              const Center(
                child: Text('Grades'),
              ),
              const Center(
                child: Text('Profile'),
              ),
            ],
          ),
          bottomNavigationBar: StreamBuilder<Object>(
            initialData: 0,
            stream: indexController.stream,
            builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
              int cIndex = snapshot.data as int;
              return CustomBottomNavigationBar(
                currentIndex: cIndex,
                onItemSelected: (int value) {
                  indexController.add(value);
                  pageController.jumpToPage(value);
                },
                items: <CustomBottomNavigationBarItem>[
                  CustomBottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today), title: const Text('Timetable')
                  ),
                  CustomBottomNavigationBarItem(
                    icon: Icon(Icons.trending_up), title: const Text('Grades')
                  ),
                  CustomBottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), title: const Text('Profile')
                  )
                ]
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final List<CustomBottomNavigationBarItem> items;
  final ValueChanged<int> onItemSelected;

  CustomBottomNavigationBar({
    Key key,
    this.currentIndex = 0,
    this.iconSize = 24,
    this.activeColor,
    this.inactiveColor = Colors.black,
    this.backgroundColor,
    @required this.items,
    @required this.onItemSelected
  }) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  @override 
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState(
      items: items,
      onItemSelected: onItemSelected,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      backgroundColor: backgroundColor,
      iconSize: iconSize,
      currentIndex: currentIndex
    );
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final double iconSize;
  Color activeColor;
  Color inactiveColor;
  Color backgroundColor;
  int currentIndex;
  List<CustomBottomNavigationBarItem> items;
  ValueChanged<int> onItemSelected;

  _CustomBottomNavigationBarState({
    Key key,
    this.currentIndex = 0,
    this.iconSize = 24,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    @required this.items,
    @required this.onItemSelected
  }) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  Widget _buildItem(CustomBottomNavigationBarItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? null : 50,
      height: 35,
      constraints: const BoxConstraints(
        maxWidth: 150
      ),
      duration: const Duration(milliseconds: 250),
      padding: isSelected ? 
        const EdgeInsets.only(left: 10, right: 20) : 
        const EdgeInsets.symmetric(horizontal: 10),
      decoration: !isSelected ?
        null :
        BoxDecoration(
          color: activeColor,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                    size: iconSize,
                    color: isSelected ? backgroundColor : inactiveColor),
                child: item.icon,
              ),
              isSelected ? 
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(color: backgroundColor),
                    child: item.title,
                  )
                ) :
                const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activeColor =
        (activeColor == null) ? Theme.of(context).accentColor : activeColor;

    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              onItemSelected(index);

              setState(() {
                currentIndex = index;
              });
            },
            child: _buildItem(item, currentIndex == index),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomNavigationBarItem {
  final Icon icon;
  final Text title;

  CustomBottomNavigationBarItem ({
    @required this.icon,
    @required this.title,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}