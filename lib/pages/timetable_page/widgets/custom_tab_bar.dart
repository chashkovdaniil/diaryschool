import 'package:diaryschool/utilities/custom_scroll_physics.dart';
import 'package:flutter/material.dart';

import 'custom_tab_bar_item.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar({Key key}) : super(key: key);
  @override 
  _CustomTabBarState createState() => _CustomTabBarState();
}
class _CustomTabBarState extends State<CustomTabBar> with TickerProviderStateMixin {
  final List<String> daysOfWeek = ["Пн","Вт","Ср","Чт","Пт","Сб","Вс"];
  
  Animation<double> _animation;
  AnimationController controller;
  ScrollController _scrollController;
  double _prevIconSize = 0;
  double _nextIconSize = 0;
  bool transitionInThisScrollSession = false;
  DateTime dateTime = DateTime.now().add(Duration(days: - DateTime.now().weekday+1));
  Color iconColor = const Color.fromARGB(255, 139, 139, 148);

  @override 
  void initState() {
    _animation = AnimationController(
      value: _prevIconSize,
      vsync: this,
      upperBound: 30.0
    );
    _scrollController = ScrollController(
      initialScrollOffset: 0.5
    );
    _scrollController.addListener(() {
      if (_scrollController.offset <= 0 && _scrollController.offset >= -30) {
        if (_scrollController.offset.toInt() == -20) {
          transitionInThisScrollSession = true;
          iconColor = const Color.fromARGB(255, 37, 46, 101);
          setState(() {});
        }
        if (_scrollController.offset >= -10 && _scrollController.offset < 0) {
          if (transitionInThisScrollSession) {
            iconColor = const Color.fromARGB(255, 139, 139, 148);
            dateTime = dateTime.subtract(const Duration(days: 7));
            print('prev');
            setState(() {});
          }
          transitionInThisScrollSession = false;
          setState(() {});
        }
        _prevIconSize = _scrollController.offset.abs();
        setState(() {});
      }
      if (_scrollController.offset > _scrollController.position.maxScrollExtent 
      && _scrollController.offset <= _scrollController.position.maxScrollExtent + 30) {
        if (_scrollController.offset.toInt() == _scrollController.position.maxScrollExtent + 20) {
          transitionInThisScrollSession = true;
          iconColor = const Color.fromARGB(255, 37, 46, 101);
          setState(() {});
        }
        if (_scrollController.offset > _scrollController.position.maxScrollExtent && _scrollController.offset <= _scrollController.position.maxScrollExtent + 10) {
          if (transitionInThisScrollSession) {
            iconColor = const Color.fromARGB(255, 139, 139, 148);
            dateTime = dateTime.add(const Duration(days: 7));
            print('next');
            setState(() {});
          }
          transitionInThisScrollSession = false;
          setState(() {});
        }
        _nextIconSize = _scrollController.offset - _scrollController.position.maxScrollExtent;
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      physics: const CustomScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            width: 30,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget w) {
                return Icon(
                    Icons.arrow_back,
                    color: iconColor,
                    size: _prevIconSize,
                  );
              }
            )
          )
        ] +
          daysOfWeek.map((e) {
            DateTime d =
            dateTime.add(Duration(days: daysOfWeek.indexOf(e)));
            return CustomTabBarItem(title: e, date: d, currentDate: DateTime.now());
          }).toList() 
        + [
          SizedBox(
            width: 30,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget child) {
                return Icon(
                  Icons.arrow_forward,
                  color: iconColor,
                  size: _nextIconSize,
                );
              }
            )
          )
        ]
      ));
  }
}