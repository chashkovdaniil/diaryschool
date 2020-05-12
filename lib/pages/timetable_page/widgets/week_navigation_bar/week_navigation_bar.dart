import 'package:diaryschool/pages/timetable_page/widgets/week_navigation_bar/bloc/bloc_week_navigation_bar.dart';
import 'package:diaryschool/pages/timetable_page/widgets/week_navigation_bar/bloc/event_week_navigation_bar.dart';
import 'package:diaryschool/pages/timetable_page/widgets/week_navigation_bar/bloc/state_week_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_scroll_physics.dart';
//import 'package:bloc/bloc.dart';

class WeekNavigationBar extends StatefulWidget {
  WeekNavigationBar({Key key}) : super(key: key);

  @override
  _WeekNavigationBarState createState() => _WeekNavigationBarState();
}

class _WeekNavigationBarState extends State<WeekNavigationBar>
    with SingleTickerProviderStateMixin {
  final List<String> daysOfWeek = [
    "Понедельник",
    "Вторник",
    "Среда",
    "Четверг",
    "Пятница",
    "Суббота",
    "Воскресенье",
  ];
  Animation<double> _animation;
  ScrollController _scrollController;
  double _prevIconSize = 0.0;
  bool transitionInThisScrollSession = false;
  Color iconColor = Colors.black;
  final WeekNavigationBarBloc _weekNavigationBarBloc = WeekNavigationBarBloc();
  DateTime dateTime =
      DateTime.now().add(Duration(days: -DateTime.now().weekday + 1));

  @override
  void initState() {
    _animation = AnimationController(
        value: _prevIconSize, vsync: this, upperBound: 50.0);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset < 0 && _scrollController.offset >= -30) {
        if (_scrollController.offset.toInt() == -29) {
          iconColor = Colors.blueAccent;
          transitionInThisScrollSession = true;
          setState(() {});
        }
        _weekNavigationBarBloc.add(UpdateIconsSizeEvent(
            prevIconSize: _scrollController.offset.abs(), nextIconSize: 0.0));
        _prevIconSize = _scrollController.offset.abs();
        setState(() {});
      } else if (_scrollController.offset >= 0) {
        if (transitionInThisScrollSession) {
          iconColor = Colors.black;
          dateTime = dateTime.add(const Duration(days: -7));
          transitionInThisScrollSession = false;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _weekNavigationBarBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    DateTime d;
    return Container(
      child: BlocBuilder<WeekNavigationBarBloc, WeekNavigationBarState>(
        bloc: _weekNavigationBarBloc,
        condition: (previous, current) =>
            previous.dateTime != current.dateTime,
        builder: (BuildContext context, WeekNavigationBarState state) {
          return SingleChildScrollView(
            controller: _scrollController,
            physics: const CustomScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
                children: daysOfWeek.map(
              (e) {
              if (state is ScrollToWeekState) {
                d = state.dateTime
                    .add(Duration(days: daysOfWeek.indexOf(e)));
//                  } else if (state is ScrollToNextWeekEvent) {
//                    d = state.dateTime
//                        .add(Duration(days: daysOfWeek.indexOf(e)));
              } else if (state is WeekNavigationBarInitial) {
                d = state.dateTime;
              }
//                  else if (state is WeekNavigationBarState) {
//                    d = state.dateTime;
//                  }
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
              },
            ).toList()),
          );
        },
      ),
//        );
//      },
    );
  }
}

//AnimatedBuilder(
//animation: _animation,
//builder: (BuildContext context, Widget w) {
//return Icon(
//Icons.arrow_back,
//color: iconColor,
//                          size: state is UpdatePrevIconSizeEvent
//                              ? state.prevIconSize
//                              : 0.0,
//);
//},
//),
