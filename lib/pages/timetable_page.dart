// import 'package:diaryschool/data/models/timetable.dart';
// import 'dart:async';
import 'package:diaryschool/common_widgets/card_widget.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class TimetablePage extends StatefulWidget {
  TimetablePage({Key key}) : super(key: key);
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final List<Map<String, dynamic>> homeworks = [
    {
      'id': 1,
      'title': 'Mathematics',
    },
    {
      'id': 2,
      'title': 'Mathematics',
      'homework': 'Page 124 #3,33,3,3'
    },
    {
      'id': 3,
      'title': 'Mathematics',
      'homework': 'Page 124 #3,33,3,3, ,kf,kf,,kf,kf,fkfkfkkffkdddddddddddddddddd',
      'start': 123456789,
      'end': 223456789,
    },
    {
      'id': 4,
      'title': 'Mathematics',
      'homework': 'Page 124 #3,33,3,3',
      'start': 123456789,
      'end': 223456789,
      'deadline': '2020.04.04 17:00',
      'isDone': true
    },
    {
      'id': 4,
      'title': 'Mathematics',
      'homework': 'Page 124 #3,33,3,3',
      'start': 123456789,
      'end': 223456789,
      'deadline': '2020.04.04 17:00'
    },
    {
      'id': 4,
      'title': 'Mathematics',
      'homework': 'Page 124 #3,33,3,3',
      'start': 123456789,
      'end': 223456789,
      'deadline': '2020.04.04 17:00'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const Text('Сен ', style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w700
            )),
            const Text('2020', style: TextStyle(
              color: accentColor,
              fontSize: 15,
              fontWeight: FontWeight.w300
            ))
        ]),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // TODO: выбор даты
            },
            child: const Text('Выбрать дату', style: TextStyle(
              color: accentColor,
              fontSize: 15,
              fontWeight: FontWeight.w300
            ))
          )
        ],
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              CustomTabBar(),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  physics: const CustomScrollPhysics(),
                  child: Column(
                    children: homeworks.map((e) {
                        return CardWidget(
                          lesson: e['title'].toString(),
                          start: e['start'] == null ? null : int.parse(e['start'].toString()),
                          end: e['end'] == null ? null : int.parse(e['end'].toString()),
                          homework: e['homework'] == null ? null : e['homework'].toString(),
                          isDone: e['isDone'] == null ? null : e['isDone'] == 1,
                        );
                      }).toList()
                    ,
                  ),
                )
              )
            ]
          ),
        ),
      )
    );
  }
}
class CustomTabBar extends StatefulWidget {
  CustomTabBar({Key key}) : super(key: key);
  @override 
  _CustomTabBarState createState() => _CustomTabBarState();
}
class _CustomTabBarState extends State<CustomTabBar> with TickerProviderStateMixin {
  final List<String> daysOfWeek = ["П","В","С","Ч","П","С","В"];
  
  Animation<double> _animation;
  AnimationController controller;
  ScrollController _scrollController;
  double _prevIconSize = 0;
  double _nextIconSize = 0;
  bool transitionInThisScrollSession = false;
  DateTime dateTime = DateTime.now().add(Duration(days: - DateTime.now().weekday+1));
  Color iconColor = Colors.black;

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
          iconColor = Colors.blueAccent;
          setState(() {});
        }
        if (_scrollController.offset >= -10 && _scrollController.offset < 0) {
          if (transitionInThisScrollSession) {
            iconColor = Colors.black;
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
          iconColor = Colors.blueAccent;
          setState(() {});
        }
        if (_scrollController.offset > _scrollController.position.maxScrollExtent && _scrollController.offset <= _scrollController.position.maxScrollExtent + 10) {
          if (transitionInThisScrollSession) {
            iconColor = Colors.black;
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      e,
                      style: const TextStyle(
                        color: accentColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      "${d.day}",
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ],
                ),
              );
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

class CustomScrollPhysics extends BouncingScrollPhysics {
  const CustomScrollPhysics({ScrollPhysics parent}) : super(parent: parent);

  @override
  BouncingScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double frictionFactor(double overscrollFraction) {
    return super.frictionFactor(overscrollFraction * 10);
  }
}