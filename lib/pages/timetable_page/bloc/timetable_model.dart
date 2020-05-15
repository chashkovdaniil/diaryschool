import 'package:flutter/cupertino.dart';

// ========================= WeekNavigationBar models =========================
enum IconType { previous, next }

class WeekNavigationBarIconModel {
  /* isActive это состояние иконки когда NavigationBar был заскролллен
  *  до достаточного оффсета для того, чтобы осуществить перемотку недели.
  *  На данный момент isActive влияет только на цвет иконки.
  */
  final double iconSize;
  final IconType iconType;
  final bool isActive;

  WeekNavigationBarIconModel({this.iconSize, this.iconType, this.isActive});
}

class WeekNavigationBarModel {
  /* [activeDay] - Выбранный пользователем день, за который отображается расписание
  *  [firstDayOfCurrentWeek] - первый день недели, которая отображается
  *  у пользователся на экране в виджете WeekNavigationBar
  */
  final WeekNavigationBarIconModel nextIcon;
  final WeekNavigationBarIconModel prevIcon;
  final DateTime activeDay;
  final DateTime firstDayOfCurrentWeek;

  WeekNavigationBarModel({
    @required this.nextIcon,
    @required this.prevIcon,
    @required this.activeDay,
    @required this.firstDayOfCurrentWeek,
  });
}
