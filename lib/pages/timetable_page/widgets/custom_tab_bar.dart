import 'package:diaryschool/common_widgets/custom_material_button.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_bloc.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_event.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_state.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/linearicons.dart';
import 'package:flutter/material.dart';
import 'package:diaryschool/pages/timetable_page/widgets/custom_tab_bar_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar({Key key, this.bloc}) : super(key: key);
  final TimetableBloc bloc;
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final List<String> daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

  DateTime firstDayOfCurrentWeek = DateTime.now().add(
    Duration(days: -DateTime.now().weekday + 1),
  );
  DateTime selectedDay = DateTime.now();
 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        buildCustomMaterialButton(
          onPressed: () {
            firstDayOfCurrentWeek = firstDayOfCurrentWeek.subtract(
              const Duration(days: 7),
            );
            setState(() {});
            widget.bloc.add(
              WeekNavigationBarEvent(
                activeDay: selectedDay,
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
        ),
        BlocBuilder<TimetableBloc, TimetableState>(
          bloc: widget.bloc,
          builder: (context, state) {
            return buildWeekWidget(state.firstDayOfCurrentWeek, state.activeDay);
          }
        ),
        buildCustomMaterialButton(
          onPressed: () {
            firstDayOfCurrentWeek = firstDayOfCurrentWeek.add(
              const Duration(days: 7),
            );
            setState(() {});
            widget.bloc.add(
              WeekNavigationBarEvent(
                activeDay: selectedDay,
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
        ),
      ],
    );
  }

  Widget buildWeekWidget(DateTime firstDayOfCurrentWeek, DateTime activeDay) {
    return Row(
      children: daysOfWeek.map((e) {
        DateTime d =
            firstDayOfCurrentWeek.add(Duration(days: daysOfWeek.indexOf(e)));
        return buildCustomMaterialButton(
          onPressed: () {
            setState(() {});
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
      }).toList(),
    );
  }
}
