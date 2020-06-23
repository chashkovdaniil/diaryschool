import 'dart:ui';

import 'package:diaryschool/screens/main/main_screen.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(DiarySchoolApp());
}

class DiarySchoolApp extends StatefulWidget {
  DiarySchoolApp({Key key}) : super(key: key);

  @override
  _DiarySchoolAppState createState() => _DiarySchoolAppState();
}

class _DiarySchoolAppState extends State<DiarySchoolApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дневник',
      debugShowCheckedModeBanner: false,
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => MainScreen(),
        TaskScreen.id: (context) => TaskScreen(),
      },
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff424242),
        primarySwatch: kColorRed,
        secondaryHeaderColor: kColorRed.shade700,
        dialogBackgroundColor: const Color(0xff424242),
        fontFamily: GoogleFonts.getFont('Open Sans').fontFamily,
        iconTheme: const IconThemeData(
          color: Color(0xffE0E0E0),
        ),
        primaryColor: kColorRed.shade700,
        primaryColorDark: kColorRed.shade700,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          highlightColor: Colors.transparent,
        ),
        dividerColor: const Color(0xffE0E0E0),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 20,
            color: kColorRed.shade700,
            letterSpacing: 0.15,
          ),
          button: TextStyle(
            color: kColorRed.shade700,
            fontSize: 14,
            letterSpacing: 1.25,
            fontWeight: FontWeight.w500,
          ),
          overline: TextStyle(
            color: const Color(0xffE0E0E0),
            fontSize: 14,
            letterSpacing: 1.25,
            fontWeight: FontWeight.w500,
          ),
          subtitle1: TextStyle(
            color: const Color(0xffE0E0E0),
            fontSize: 16,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.15,
          ),
          subtitle2: TextStyle(
            color: const Color(0xffE0E0E0),
            fontSize: 14,
            fontWeight: FontWeight.w200,
            letterSpacing: 0.1,
          ),
          bodyText2: TextStyle(
            color: const Color(0xffE0E0E0),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        colorScheme: ColorScheme(
          primary: kColorRed.shade700,
          primaryVariant: kColorRed.shade700,
          onPrimary: const Color(0xffE0E0E0),
          surface: const Color(0xff424242),
          onSurface: const Color(0xffE0E0E0),
          background: const Color(0xff424242),
          onBackground: const Color(0xffE0E0E0),
          error: kColorRed.shade900,
          onError: kColorBlack,
          secondary: kColorRed.shade700,
          secondaryVariant: kColorRed.shade700,
          onSecondary: kColorBlack,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: kColorRed.shade700,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 25,
              color: kColorRed.shade700,
              letterSpacing: 0.15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: kColorRed.shade700,
          ),
          iconTheme: IconThemeData(color: kColorRed.shade700),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 25,
              color: kColorRed.shade700,
              letterSpacing: 0.15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: kBorderRadius,
          ),
        ),
        buttonTheme: ButtonThemeData(
          splashColor: kColorRed.shade100,
          highlightColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: kColorBlack,
        ),
        primarySwatch: kColorRed,
        secondaryHeaderColor: kColorRed.shade700,
        primaryColor: kColorRed.shade700,
        fontFamily: GoogleFonts.getFont('Open Sans').fontFamily,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 20,
            color: kColorRed.shade700,
            letterSpacing: 0.15,
          ),
          button: TextStyle(
            color: kColorRed.shade700,
            fontSize: 14,
            letterSpacing: 1.25,
            fontWeight: FontWeight.w500,
          ),
          overline: TextStyle(
            color: kColorBlack,
            fontSize: 14,
            letterSpacing: 1.25,
            fontWeight: FontWeight.w500,
          ),
          subtitle1: TextStyle(
            color: kColorBlack,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.15,
          ),
          subtitle2: TextStyle(
            color: kColorBlack,
            fontSize: 14,
            fontWeight: FontWeight.w200,
            letterSpacing: 0.1,
          ),
          bodyText2: TextStyle(
            color: kColorBlack,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        colorScheme: ColorScheme(
          primary: kColorRed.shade700,
          primaryVariant: kColorRed.shade700,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: kColorBlack,
          background: Colors.white,
          onBackground: kColorBlack,
          error: kColorRed.shade900,
          onError: kColorBlack,
          secondary: kColorRed.shade700,
          secondaryVariant: kColorRed.shade700,
          onSecondary: kColorBlack,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
