import 'package:diaryschool/pages/main_page.dart';
import 'package:diaryschool/pages/task_page.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

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
      initialRoute: MainPage.id,
      routes: {
        MainPage.id: (context) => MainPage(),
        TaskPage.id: (context) => TaskPage()
      },
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        accentColor: Colors.white,
        secondaryHeaderColor: kColorRed,
        primaryColor: kColorRed,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: kHeadline6Color,
          ),
          bodyText2: TextStyle(
            color: kBodyText2Color,
          ),
          bodyText1: TextStyle(
            color: kBodyText1Color,
          ),
        ),
        colorScheme: ColorScheme.light(primary: kColorRed),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(15),
          // ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      // darkTheme: ThemeData(

      // ),
    );
  }
}
