import 'package:diaryschool/pages/timetable_page/bloc/timetable_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TimetableState extends Equatable {
  const TimetableState();

  @override
  List<Object> get props => [];
}

// ==================== WeekNavigationBarState ====================
class WeekNavigationBarState extends TimetableState {
  ///[wasActivated] - [null] если не было скролла да достаточного оффсета для смены недели. [IconType.next] или [IconType.previous] если был скролл на достаточный оффсет для смены недели.
  final WeekNavigationBarIconModel prevIcon;
  final WeekNavigationBarIconModel nextIcon;
//  final IconType wasActivated;
  final DateTime activeDay;
  final DateTime firstDayOfCurrentWeek;

  WeekNavigationBarState({
    @required this.nextIcon,
    @required this.prevIcon,
//    @required this.wasActivated,
    @required this.activeDay,
    @required this.firstDayOfCurrentWeek,
  });
  @override
  List<Object> get props => [
        nextIcon,
        prevIcon,
//        wasActivated,
        activeDay,
        firstDayOfCurrentWeek,
      ];
}

// ==================== Initial State ====================
class InitialTimetableState extends TimetableState {
  // [activeDay] - По умолчанию сегодняшний день
  // [firstDayOfCurrentWeek] - По умолчанию первый день текущей недели.
  final DateTime activeDay = DateTime.now();
  final DateTime firstDayOfCurrentWeek =
      DateTime.now().add(Duration(days: -DateTime.now().weekday + 1));
  final WeekNavigationBarIconModel prevIcon = WeekNavigationBarIconModel(
      iconType: IconType.previous, iconSize: 0, isActive: false);
  final WeekNavigationBarIconModel nextIcon = WeekNavigationBarIconModel(
      iconType: IconType.previous, iconSize: 0, isActive: false);

  @override
  List<Object> get props => [activeDay, firstDayOfCurrentWeek];
}