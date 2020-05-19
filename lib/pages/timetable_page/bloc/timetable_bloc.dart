import 'dart:async';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_event.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_model.dart';
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
      yield updateWeekNavigationBarState(event);
    }
  }

  WeekNavigationBarState updateWeekNavigationBarState(
      WeekNavigationBarEvent event) {
    /// Обновляет состояние WeekNavigationBatState.

    DateTime firstDayOfCurrentWeek;

    /// Если скролл скролл в правую сторону(для перемотки вперед)
    // if (event.offset.toInt() >= event.maxScrollOffset.toInt()) {
    //   /// Тут формируется состояние для иконки вперед

    //   /// [firstDayOfCurrentWeek] - Тут проверяются условия для перемотки на одну неделю вперед
    //   if (event.maxScrollOffset.toInt() == event.offset.toInt() &&
    //       event.wasActivated == IconType.next) {
    //     firstDayOfCurrentWeek =
    //         event.firstDayOfCurrentWeek.add(const Duration(days: 7));
    //   }
    // }

    /// Если скролл в левую сторону(для переметки назад)
    // if (event.offset.toInt() <= 0) {
  

    //   /// [firstDayOfCurrentWeek] - Тут проверяются условия для перемотки на одну неделю назад
    //   if (event.offset.toInt() == 0 &&
    //       event.wasActivated == IconType.previous) {
    //     firstDayOfCurrentWeek =
    //         event.firstDayOfCurrentWeek.subtract(const Duration(days: 7));
    //   }

    // }
    return WeekNavigationBarState(
        activeDay: event.activeDay,
        firstDayOfCurrentWeek:
            firstDayOfCurrentWeek ?? event.firstDayOfCurrentWeek);
  }
}
