import 'package:diaryschool/common_widgets/custom_material_button.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_bloc.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_event.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_state.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/linearicons.dart';
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

  DateTime firstDayOfCurrentWeek;
  DateTime selectedDay = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        buildCustomMaterialButton(
          onPressed: () {
            widget.bloc.add(
              WeekNavigationBarEvent(
                activeDay: selectedDay,
                firstDayOfCurrentWeek: firstDayOfCurrentWeek.subtract(
                  const Duration(days: 7),
                ),
              ),
            );
          },
          child: Container(
            width: 30,
            height: 40,
            child: const Icon(
              Linearicons.arrow_left,
              color: kAccentColorText,
              size: 20,
            ),
          ),
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
        buildCustomMaterialButton(
          onPressed: () {
            widget.bloc.add(
              WeekNavigationBarEvent(
                activeDay: selectedDay,
                firstDayOfCurrentWeek: firstDayOfCurrentWeek.add(
                  const Duration(days: 7),
                ),
              ),
            );
          },
          child: Container(
            width: 30,
            height: 40,
            child: const Icon(
              Linearicons.arrow_right,
              color: kAccentColorText,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWeekWidget(DateTime firstDayOfCurrentWeek, DateTime activeDay) {
    return Row(
      children: daysOfWeek.map(
        (e) {
          DateTime d =
              firstDayOfCurrentWeek.add(Duration(days: daysOfWeek.indexOf(e)));
          return buildCustomMaterialButton(
            onPressed: () {
              widget.bloc.add(
                WeekNavigationBarEvent(
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
