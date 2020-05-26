import 'package:diaryschool/common_widgets/custom_material_button.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_bloc.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_event.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_state.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/linearicons.dart';
import 'package:flutter/material.dart';
import 'package:diaryschool/pages/timetable_page/widgets/custom_tab_bar_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabBar extends StatelessWidget {
  final TimetableBloc bloc;
  CustomTabBar({Key key, this.bloc}) : super(key: key);

  final List<String> daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

  @override
  Widget build(BuildContext context) {
    // DateTime selectedDay = DateTime.now();
    DateTime firstDayOfCurrentWeek =
        DateTime.now().add(Duration(days: -DateTime.now().weekday + 1));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        BlocBuilder<TimetableBloc, TimetableState>(
          bloc: bloc,
          builder: (context, state) {
            return CustomMaterialButton(
              onPressed: () {
                firstDayOfCurrentWeek = firstDayOfCurrentWeek.subtract(
                  const Duration(days: 7),
                );
                bloc.add(
                  WeekNavigationBarEvent(
                    activeDay: state.activeDay,
                    firstDayOfCurrentWeek: firstDayOfCurrentWeek,
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
            );
          },
        ),
        BlocBuilder<TimetableBloc, TimetableState>(
          bloc: bloc,
          builder: (context, state) {
            return buildWeekWidget(
                state.firstDayOfCurrentWeek, state.activeDay);
          },
        ),
        BlocBuilder<TimetableBloc, TimetableState>(
          bloc: bloc,
          builder: (context, state) {
            return CustomMaterialButton(
              onPressed: () {
                firstDayOfCurrentWeek = firstDayOfCurrentWeek.add(
                  const Duration(days: 7),
                );
                bloc.add(
                  WeekNavigationBarEvent(
                    activeDay: state.activeDay,
                    firstDayOfCurrentWeek: firstDayOfCurrentWeek,
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
            );
          },
        ),
      ],
    );
  }

  Widget buildWeekWidget(DateTime firstDayOfCurrentWeek, DateTime activeDay) {
    return Row(
      children: daysOfWeek.map((e) {
        DateTime d =
            firstDayOfCurrentWeek.add(Duration(days: daysOfWeek.indexOf(e)));
        return Container(
          margin: const EdgeInsets.all(3.0),
          child: CustomMaterialButton(
            onPressed: () {
              bloc.add(
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
          ),
        );
      }).toList(),
    );
  }
}
