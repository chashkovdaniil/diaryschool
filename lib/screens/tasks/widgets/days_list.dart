import 'package:diaryschool/common_widgets/custom_material_button.dart';
import 'package:diaryschool/screens/tasks/bloc/timetable_bloc.dart';
import 'package:diaryschool/screens/tasks/bloc/timetable_event.dart';
import 'package:diaryschool/screens/tasks/bloc/timetable_state.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysList extends StatelessWidget {
  final TimetableBloc bloc;
  DaysList({Key key, this.bloc}) : super(key: key);

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
        CustomMaterialButton(
          onPressed: () {
            firstDayOfCurrentWeek = firstDayOfCurrentWeek.subtract(
              const Duration(days: 7),
            );
            bloc.add(
              WeekNavigationBarEvent(
                activeDay: bloc.state.activeDay,
                firstDayOfCurrentWeek: firstDayOfCurrentWeek,
              ),
            );
          },
          child: Container(
            width: 30,
            height: 40,
            child: const Icon(
              Icons.keyboard_arrow_left,
              size: 20,
            ),
          ),
        ),
        BlocBuilder<TimetableBloc, TimetableState>(
          bloc: bloc,
          builder: (context, state) {
            return buildWeekWidget(
                context, state.firstDayOfCurrentWeek, state.activeDay);
          },
        ),
        CustomMaterialButton(
          onPressed: () {
            firstDayOfCurrentWeek = firstDayOfCurrentWeek.add(
              const Duration(days: 7),
            );
            bloc.add(
              WeekNavigationBarEvent(
                activeDay: bloc.state.activeDay,
                firstDayOfCurrentWeek: firstDayOfCurrentWeek,
              ),
            );
          },
          child: Container(
            width: 30,
            height: 40,
            child: const Icon(
              Icons.keyboard_arrow_right,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWeekWidget(BuildContext context, DateTime firstDayOfCurrentWeek,
      DateTime activeDay) {
    return Row(
      children: daysOfWeek.map((day) {
        DateTime date =
            firstDayOfCurrentWeek.add(Duration(days: daysOfWeek.indexOf(day)));
        bool isCurrently = activeDay.day == date.day &&
            activeDay.month == date.month &&
            activeDay.year == date.year;
        return Container(
          margin: const EdgeInsets.all(3.0),
          child: CustomMaterialButton(
            onPressed: () {
              bloc.add(
                WeekNavigationBarEvent(
                  activeDay: date,
                  firstDayOfCurrentWeek: firstDayOfCurrentWeek,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: isCurrently ? kPrimaryColor : null,
                borderRadius: kBorderRadius,
                boxShadow: isCurrently ? kDefaultShadow : [],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              child: Column(
                children: <Widget>[
                  Text(
                    day,
                    style: TextStyle(
                      color: isCurrently
                          ? Colors.white
                          : Theme.of(context).colorScheme.onBackground,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "${date.day}",
                    style: TextStyle(
                      color: isCurrently
                          ? Theme.of(context).colorScheme.onPrimary
                          : kColorRed.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // child: DaysListItem(
            //   isCurrently: ,
            //   title: day,
            //   date: d,
            // ),
          ),
        );
      }).toList(),
    );
  }
}
