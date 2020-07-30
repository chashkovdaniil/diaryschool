import 'package:flutter/material.dart';

const kColorRed = MaterialColor(0xffd13438, {
  100: Color(0xffFDCED4),
  200: Color(0xffEC9C9E),
  300: Color(0xffE27679),
  400: Color(0xffEC5759),
  500: Color(0xffF24741),
  600: Color(0xffE33D3D),
  700: Color(0xffD13438),
  800: Color(0xffC42E30),
  900: Color(0xffB52426),
});
const kColorBlack = Color(0xff626262);
const kColorGrey1 = Color(0xffe0e0e0);
const kColorGrey2 = Color(0xffa3a2a2);

const kPrimaryColor = kColorRed;
const kAccentColor = Colors.white;

const kBackgroundColor = kPrimaryColor;
const kPrimaryColorText = Color.fromARGB(255, 37, 46, 101);
const kAccentColorText = Color.fromARGB(255, 139, 139, 148);
const kScaffoldBackgroundColor = Colors.white;
const kCardWidgetBackgroundColor = Color(0xffffffff);

BorderRadius kBorderRadius = BorderRadius.circular(15);
const kDefaultPadding = 20.0;
const kDefaultShadow = [
  BoxShadow(
    offset: Offset(0, 4),
    color: Colors.black12,
    blurRadius: 8,
  ),
];
const Map<int, String> kMonthIntToString = {
  1: 'Янв',
  2: 'Фев',
  3: 'Мар',
  4: 'Апр',
  5: 'Май',
  6: 'Июнь',
  7: 'Июль',
  8: 'Авг',
  9: 'Сен',
  10: 'Окт',
  11: 'Ноя',
  12: 'Дек',
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
