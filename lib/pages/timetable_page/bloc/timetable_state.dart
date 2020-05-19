import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TimetableState extends Equatable {
  const TimetableState();

  @override
  List<Object> get props => [];
}

// ==================== WeekNavigationBarState ====================
class WeekNavigationBarState extends TimetableState {

  final DateTime activeDay;
  final DateTime firstDayOfCurrentWeek;

  WeekNavigationBarState({
    @required this.activeDay,
    @required this.firstDayOfCurrentWeek,
  });
  @override
  List<Object> get props => [
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

  @override
  List<Object> get props => [activeDay, firstDayOfCurrentWeek];
}
