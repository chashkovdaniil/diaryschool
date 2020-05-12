import 'package:diaryschool/pages/timetable_page/bloc/timetable_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent([List props = const []]) : super();
}

// ======================== WeekNavigationBar ========================

class WeekNavigationBarEvent extends TimetableEvent {
  final WeekNavigationBarIconModel prevIcon;
  final WeekNavigationBarIconModel nextIcon;
  final DateTime activeDay;
  final DateTime firstDayOfCurrentWeek;

  WeekNavigationBarEvent({
    @required this.nextIcon,
    @required this.prevIcon,
    @required this.activeDay,
    @required this.firstDayOfCurrentWeek,
  });
  @override
  List<Object> get props => [
        nextIcon,
        prevIcon,
        activeDay,
        firstDayOfCurrentWeek,
      ];
}
