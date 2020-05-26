import 'package:flutter/material.dart';

const Color kPrimaryColor = Color.fromARGB(255, 231, 72, 86);
const Color kAccentColor = Color.fromARGB(255, 243, 163, 170);
const Color kBackgroundColor = Color.fromARGB(250, 249, 249, 251);
const Color kBackgroundColorBodies = Colors.white;
const Color kBackgroundColorAppBarHomePage = Color.fromARGB(255, 255, 237, 213);
const Color kBackgroundColorAppBarTaskPage = Color.fromARGB(255, 255, 237, 213);
const Color kPrimaryColorText = Color.fromARGB(255, 37, 46, 101);
const Color kAccentColorText = Color.fromARGB(255, 139, 139, 148);
const Color kSelectedItemColorOnBNB = Color(0xffda3f2f);
const Color kUnselectedItemColorOnBNB = Color(0xffb0b6bb);
const Color kScaffoldBackgroundColor = Color(0xffffffff);
const Color kHeadline6Color = Color(0xffda3f2f);
const Color kColorRed = Color(0xffda3f2f);
const Color kCardWidgetBackgroundColor = Color(0xfff4f6f6);
const Color kBodyText1Color = Color(0xffda3f2f);
const Color kBodyText2Color = Color(0xffb0b6bb);
const List<BoxShadow> kShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.16),
    blurRadius: 10,
  ),
];
const Map<int, String> kMonthIntToString = {
  1: "Янв",
  2: "Фев",
  3: "Мар",
  4: "Апр",
  5: "Май",
  6: "Июнь",
  7: "Июль",
  8: "Авг",
  9: "Сен",
  10: "Окт",
  11: "Ноя",
  12: "Дек",
};
const Map<int, String> kDayOfWeekOnString = {
  1: 'Понедельник',
  2: 'Вторник',
  3: 'Среда',
  4: 'Четверг',
  5: 'Пятница',
  6: 'Суббота',
  7: 'Воскресенье'
};
const Map<int, String> kShortDayOfWeekOnString = {
  1: 'Пн',
  2: 'Вт',
  3: 'Ср',
  4: 'Чт',
  5: 'Пт',
  6: 'Сб',
  7: 'Вс'
};
BorderRadius kBorderRadiusCardWidget = BorderRadius.circular(15);
const BorderRadius kBorderRadiusBodyPages = BorderRadius.vertical(top: Radius.circular(25));
BorderRadius kButtonBorderRadius = BorderRadius.circular(8.0);

const double kIconSlideActionSize = 30.0;
