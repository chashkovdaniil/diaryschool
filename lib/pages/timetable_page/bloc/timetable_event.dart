import 'package:diaryschool/pages/timetable_page/bloc/timetable_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent([List props = const []]) : super();
}

// ======================== WeekNavigationBar ========================

class WeekNavigationBarEvent extends TimetableEvent {
  final double offset;
  final double maxScrollOffset;
  final IconType wasActivated;
  final DateTime activeDay;
  final DateTime firstDayOfCurrentWeek;

  WeekNavigationBarEvent({
    this.wasActivated,
    this.maxScrollOffset,
    this.offset,
    @required this.activeDay,
    @required this.firstDayOfCurrentWeek,
  });
  @override
  List<Object> get props => [
        wasActivated,
        maxScrollOffset,
        offset,
        activeDay,
        firstDayOfCurrentWeek,
      ];
}
