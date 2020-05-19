import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent([List props = const []]) : super();
}

// ======================== WeekNavigationBar ========================

class WeekNavigationBarEvent extends TimetableEvent {
  final DateTime activeDay;
  final DateTime firstDayOfCurrentWeek;

  WeekNavigationBarEvent({
    @required this.activeDay,
    @required this.firstDayOfCurrentWeek,
  });
  @override
  List<Object> get props => [
        activeDay,
        firstDayOfCurrentWeek,
      ];
}
