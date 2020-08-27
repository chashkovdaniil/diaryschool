import 'package:flutter/material.dart' show BorderRadius, BoxShadow, Color, Colors, MaterialColor, Offset;

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
