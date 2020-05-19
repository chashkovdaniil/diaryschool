import 'package:flutter/cupertino.dart';

// ========================= WeekNavigationBar models =========================
enum IconType { previous, next }

class WeekNavigationBarModel {
  /* [activeDay] - Выбранный пользователем день, за который отображается расписание
  *  [firstDayOfCurrentWeek] - первый день недели, которая отображается
  *  у пользователся на экране в виджете WeekNavigationBar
  */
  final DateTime activeDay;
  final DateTime firstDayOfCurrentWeek;

  WeekNavigationBarModel({
    @required this.activeDay,
    @required this.firstDayOfCurrentWeek,
  });
}
