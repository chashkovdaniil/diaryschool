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
    WeekNavigationBarIconModel prevIcon;
    WeekNavigationBarIconModel nextIcon;
    DateTime firstDayOfCurrentWeek;

    /// Если скролл скролл в правую сторону(для перемотки вперед)
    if (event.offset.toInt() >= event.maxScrollOffset.toInt()) {
      /// Тут формируется состояние для иконки вперед
      nextIcon = WeekNavigationBarIconModel(
          iconSize: event.offset,
          iconType: IconType.next,
          isActive: (event.wasActivated == IconType.next &&
                  event.offset.toInt() != event.maxScrollOffset.toInt()) ||
              (event.offset.toInt() >= event.maxScrollOffset.toInt() + 20));

      /// [firstDayOfCurrentWeek] - Тут проверяются условия для перемотки на одну неделю вперед
      if (event.maxScrollOffset.toInt() == event.offset.toInt() &&
          event.wasActivated == IconType.next) {
        firstDayOfCurrentWeek =
            event.firstDayOfCurrentWeek.add(const Duration(days: 7));
      }

      /// Тут формируется состояние для иконки назад
      prevIcon = WeekNavigationBarIconModel(
        iconSize: 0,
        iconType: IconType.previous,
        isActive: false,
      );
    }

    /// Если скролл в левую сторону(для переметки назад)
    if (event.offset.toInt() <= 0) {
      /// Тут формируется состояние для иконки назад
      prevIcon = WeekNavigationBarIconModel(
        iconSize: event.offset.abs(),
        iconType: IconType.previous,
        isActive: (event.wasActivated == IconType.previous &&
                event.offset.toInt() != 0) ||
            (event.offset.toInt() <= event.maxScrollOffset.toInt() - 20),
      );

      /// [firstDayOfCurrentWeek] - Тут проверяются условия для перемотки на одну неделю назад
      if (event.offset.toInt() == 0 &&
          event.wasActivated == IconType.previous) {
        firstDayOfCurrentWeek =
            event.firstDayOfCurrentWeek.subtract(const Duration(days: 7));
      }

      /// Тут формируется состояние для иконки вперед
      nextIcon = WeekNavigationBarIconModel(
        iconSize: 0,
        iconType: IconType.next,
        isActive: false,
      );
    }
    return WeekNavigationBarState(
        nextIcon: nextIcon,
        prevIcon: prevIcon,
        activeDay: event.activeDay,
        firstDayOfCurrentWeek:
            firstDayOfCurrentWeek ?? event.firstDayOfCurrentWeek);
  }
}