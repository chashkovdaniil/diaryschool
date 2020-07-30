import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TimetableState extends Equatable {
  final DateTime activeDay;
  final DateTime firstDayOfCurrentWeek;

  TimetableState({
    @required this.activeDay,
    @required this.firstDayOfCurrentWeek,
  });

  @override
  List<Object> get props => [
        activeDay,
        firstDayOfCurrentWeek,
      ];
}

// ==================== WeekNavigationBarState ====================
class WeekNavigationBarState extends TimetableState {
  @override
  final DateTime activeDay;
  @override
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
  @override
  final DateTime activeDay = DateTime.now();
  @override
  final DateTime firstDayOfCurrentWeek =
      DateTime.now().add(Duration(days: -DateTime.now().weekday + 1));

  @override
  List<Object> get props => [activeDay, firstDayOfCurrentWeek];
}
