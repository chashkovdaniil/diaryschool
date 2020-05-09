// import 'package:diaryschool/data/models/timetable.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.check_circle_outline),
          tooltip: 'Показать невыполненное',
          onPressed: () {
            // ToDo: переход на страницу несделанного
          },
        ),
        title: Text('27 Сентября 2020'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            tooltip: 'Выбрать дату',
            onPressed: (){
              // ToDo: выбор даты
            }
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CustomTabBar()
          // Timetable()
        ]
      )
    );
  }
}
class CustomTabBar extends StatefulWidget {
  @override 
  _CustomTabBarState createState() => _CustomTabBarState();
}
class _CustomTabBarState extends State<CustomTabBar> with TickerProviderStateMixin {
  ScrollPhysics _physics = ClampingScrollPhysics();
  Animation<double> _animation;
  ScrollController _scrollController;
  double _prevIconSize = 0.0;

  AnimationController controller;
  @override 
  void initState() {
    _animation = AnimationController(
      value: _prevIconSize,
      vsync: this,
      upperBound: 50.0
    );
    _scrollController = ScrollController(
      initialScrollOffset: 0.5
    );
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && _physics is BouncingScrollPhysics) {
        _physics = const ClampingScrollPhysics();
        setState((){});
      }
      if (_scrollController.offset <= 0 && _scrollController.offset > -30) {
        _physics = const BouncingScrollPhysics();
        _prevIconSize = _scrollController.offset.abs();
        setState(() {});
      }
    });
    super.initState();
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onPanDown: (d) => print(_scrollController.offset), child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics: _physics,
        child: Row(
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget w) {
                return Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: _prevIconSize,
                  );
              }
            ),
            TabBarItem(title: 'Понедельник'),
            TabBarItem(title: 'Вторник'),
            TabBarItem(title: 'Среда'),
            TabBarItem(title: 'Четверг'),
            TabBarItem(title: 'Пятница'),
            TabBarItem(title: 'Суббота'),
            TabBarItem(title: 'Воскресенье')
          ]
        ),
    ));
  }
}
class TabBarItem extends StatelessWidget {
  final String title;
  final int index;
  TabBarItem({Key key, this.title, this.index}) : super(key: key);
  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(title,
        style: const TextStyle(
          fontSize: 20
        ),
      ),
    );
  }
}