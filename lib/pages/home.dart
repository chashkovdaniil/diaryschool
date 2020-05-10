// import 'package:diaryschool/data/models/timetable.dart';
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
              onPressed: () {
                // ToDo: выбор даты
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          CustomTabBar(),
        ],
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
//  ScrollPhysics _physics = ClampingScrollPhysics();
  Animation<double> _animation;
  ScrollController _scrollController;
//  ScrollPhysics _scrollPhysics;
  double _prevIconSize = 0.0;
  bool transitionInThisScrollSession = false;
  Color iconColor = Colors.black;
  DateTime dateTime = DateTime.now().add(Duration(days: - DateTime.now().weekday+1));
  final List<String> daysOfWeek = [
    "Понедельник",
    "Вторник",
    "Среда",
    "Четверг",
    "Пятница",
    "Суббота",
    "Воскресенье",
  ];

  AnimationController controller;
  @override
  void initState() {
    _animation = AnimationController(
        value: _prevIconSize, vsync: this, upperBound: 50.0);
    _scrollController = ScrollController(initialScrollOffset: 0.5);
    _scrollController.addListener(() {
//      if (_scrollController.offset > 0 && _physics is BouncingScrollPhysics) {
//        _physics = const ClampingScrollPhysics();
//        setState(() {});
//      }
      if (_scrollController.offset <= 0 && _scrollController.offset >= -30) {
        if (_scrollController.offset.toInt() == -29) {
          iconColor = Colors.blueAccent;
          transitionInThisScrollSession = true;
          setState(() {});
        }
        if (_scrollController.offset == 0) {
          if (transitionInThisScrollSession) {
            iconColor = Colors.black;
            dateTime = dateTime.add(const Duration(days: -7));
            setState(() {});
          }
          transitionInThisScrollSession = false;
          setState(() {});
        }
//        print(_scrollController.offset);
//        _physics = const BouncingScrollPhysics();
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
    return Container(
      child: NotificationListener(
        onNotification: (not) {
//            print(not.runtimeType);
          if (not is ScrollEndNotification && !transitionInThisScrollSession) {
//            print(transitionInThisScrollSession);
//            print(_scrollController.offset);
          }
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: CustomScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
                  AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget w) {
                        return Icon(
                          Icons.arrow_back,
                          color: iconColor,
                          size: _prevIconSize,
                        );
                      }),
                ] +
                daysOfWeek.map((e) {
                  DateTime d =
                      dateTime.add(Duration(days: daysOfWeek.indexOf(e)));
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          e,
                          style: const TextStyle(fontSize: 25.0),
                        ),
                        Text(
                            "${d.day < 10 ? "0" + d.day.toString() : d.day}.${d.month < 10 ? "0" + d.month.toString() : d.month}"),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

class TabBarItem extends StatelessWidget {
  final String title;
  final int index;
  TabBarItem({Key key, this.title, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
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
