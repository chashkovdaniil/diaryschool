import 'dart:async';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_event.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  @override
  TimetableState get initialState => InitialTimetableState();

  @override
  Stream<TimetableState> mapEventToState(
    TimetableEvent event,
  ) async* {
    if (event is WeekNavigationBarEvent) {
      yield WeekNavigationBarState(
          activeDay: event.activeDay,
          firstDayOfCurrentWeek: event.firstDayOfCurrentWeek);
    }
  }
}
