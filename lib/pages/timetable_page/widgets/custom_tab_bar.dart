import 'package:diaryschool/pages/timetable_page/bloc/timetable_bloc.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_event.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_model.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_state.dart';
import 'package:diaryschool/utilities/custom_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diaryschool/pages/timetable_page/widgets/custom_tab_bar_item.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar({Key key, this.bloc}) : super(key: key);
  final TimetableBloc bloc;
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final List<String> daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

  ScrollController _scrollController;
  DateTime firstDayOfCurrentWeek;
  IconType wasActivated;
  double offset;
  double maxScrollOffset;
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 0.0001);
    _scrollController.addListener(() {
      offset = _scrollController.offset;
      maxScrollOffset = _scrollController.position.maxScrollExtent;
      widget.bloc.add(
        WeekNavigationBarEvent(
            maxScrollOffset: maxScrollOffset,
            offset: offset,
            wasActivated: wasActivated,
            activeDay: selectedDay,
            firstDayOfCurrentWeek: firstDayOfCurrentWeek),
      );
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
          BlocBuilder(
            bloc: widget.bloc,
            condition: (prevState, currentState) {
              return (currentState is InitialTimetableState ||
                      prevState is InitialTimetableState) ||
                  (currentState is WeekNavigationBarState &&
                      prevState is WeekNavigationBarState &&
                      currentState.prevIcon.iconSize !=
                          prevState.prevIcon.iconSize);
            },
            builder: (BuildContext context, state) {
              if (state is WeekNavigationBarState) {
                wasActivated =
                    state.prevIcon.isActive ? IconType.previous : null;
                return buildIcon(Icons.arrow_back, state.prevIcon.iconSize,
                    state.prevIcon.isActive ? Colors.blueAccent : Colors.black);
              } else if (state is InitialTimetableState) {
                wasActivated =
                    state.prevIcon.isActive ? IconType.previous : null;
                return buildIcon(Icons.arrow_back, state.prevIcon.iconSize,
                    state.prevIcon.isActive ? Colors.blueAccent : Colors.black);
              }
              return null;
            },
          ),
          BlocBuilder(
            bloc: widget.bloc,
            condition: (prevState, currentState) {
              return (currentState is InitialTimetableState ||
                      prevState is InitialTimetableState) ||
                  (currentState is WeekNavigationBarState &&
                          prevState is WeekNavigationBarState) &&
                      (currentState.firstDayOfCurrentWeek
                                  .difference(prevState.firstDayOfCurrentWeek)
                                  .inDays
                                  .abs() >
                              0 ||
                          (currentState.activeDay.day !=
                                  prevState.activeDay.day ||
                              currentState.activeDay.month !=
                                  prevState.activeDay.month ||
                              currentState.activeDay.year !=
                                  prevState.activeDay.year));
            },
            builder: (BuildContext context, state) {
              if (state is WeekNavigationBarState) {
                firstDayOfCurrentWeek = state.firstDayOfCurrentWeek;
                return buildWeekWidget(firstDayOfCurrentWeek, state.activeDay);
              } else if (state is InitialTimetableState) {
                firstDayOfCurrentWeek = state.firstDayOfCurrentWeek;
                return buildWeekWidget(firstDayOfCurrentWeek, state.activeDay);
              }
              return null;
            },
          ),
          BlocBuilder(
            bloc: widget.bloc,
            condition: (prevState, currentState) {
              return (currentState is InitialTimetableState ||
                      prevState is InitialTimetableState) ||
                  (currentState is WeekNavigationBarState &&
                      prevState is WeekNavigationBarState &&
                      currentState.nextIcon.iconSize > 0 &&
                      currentState.nextIcon.iconSize !=
                          prevState.nextIcon.iconSize);
            },
            builder: (BuildContext context, state) {
              if (state is WeekNavigationBarState) {
                wasActivated = state.nextIcon.isActive ? IconType.next : null;
                return buildIcon(Icons.arrow_forward, state.nextIcon.iconSize,
                    state.nextIcon.isActive ? Colors.blueAccent : Colors.black);
              } else if (state is InitialTimetableState) {
                wasActivated = state.nextIcon.isActive ? IconType.next : null;
                return buildIcon(Icons.arrow_forward, state.nextIcon.iconSize,
                    state.nextIcon.isActive ? Colors.blueAccent : Colors.black);
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget buildIcon(IconData icon, double iconSize, Color iconColor) {
    return AnimatedContainer(
      curve: Curves.linear,
      duration: const Duration(milliseconds: 200),
      width: 30,
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize.abs(),
      ),
    );
  }

  Widget buildWeekWidget(DateTime firstDayOfCurrentWeek, DateTime activeDay) {
    return Row(
      children: daysOfWeek.map(
        (e) {
          DateTime d =
              firstDayOfCurrentWeek.add(Duration(days: daysOfWeek.indexOf(e)));
          return InkWell(
            onTap: () {
              selectedDay = d;
              widget.bloc.add(
                WeekNavigationBarEvent(
                  wasActivated: wasActivated,
                  offset: offset,
                  maxScrollOffset: maxScrollOffset,
                  activeDay: d,
                  firstDayOfCurrentWeek: firstDayOfCurrentWeek,
                ),
              );
            },
            child: CustomTabBarItem(
              isCurrently: activeDay.day == d.day &&
                  activeDay.month == d.month &&
                  activeDay.year == d.year,
              title: e,
              date: d,
            ),
          );
        },
      ).toList(),
    );
  }
}
