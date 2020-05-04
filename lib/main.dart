import 'package:diaryschool/Pages/Timetable/EditTimetableArgs.dart';
import 'package:flutter/material.dart';
import 'package:diaryschool/Pages/Grades/GradesPage.dart';
import 'package:diaryschool/Pages/Home/HomePage.dart';
import 'package:diaryschool/Pages/NotDone/NotDonePage.dart';
import 'package:diaryschool/Pages/Timetable/EditTimetable.dart';
import 'package:diaryschool/Pages/Homework/EditHomeworkPage.dart';
import 'package:diaryschool/Pages/Subjects/SubjectsPage.dart';
import 'package:diaryschool/Pages/Settings/SettingsPage.dart';
import 'package:diaryschool/Pages/Update/UpdatePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:diaryschool/Locale/Locale.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

void main() {
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дневник',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/editTimetable') {
          final EditTimetableArgs args = settings.arguments;

          return MaterialPageRoute(
            builder: (context) {
              return EditTimetablePage(
                day: (args == null) ? DateTime.now().weekday : args.day
              );
            }
          );
        }
      },
      routes: {
        '/':(BuildContext context) => HomePage(),
        '/subjects':(BuildContext context) => SubjectsPage(), // Список предметов
        '/homework':(BuildContext context) => EditHomeworkPage(), // Страница с домашним заданием
        '/notdone':(BuildContext context) => NotDonePage(), // Страница невыполненных домашних заданий
        '/settings':(BuildContext context) => SettingsPage(), // Страница настроек
        '/grades':(BuildContext context) => GradesPage(), // Страница с оценками
        '/update':(context) => UpdatePage()
      },
      theme: ThemeData(primaryColor: Colors.white),
      localizationsDelegates: [
        const DLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ru', ''),
      ],
    );
  }
}
