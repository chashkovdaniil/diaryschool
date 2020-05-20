
import 'package:diaryschool/pages/main_page.dart';
import 'package:diaryschool/pages/task_page.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/task': (context) => TaskPage()
      },
      theme: ThemeData(
        primaryColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
      ),
      darkTheme: ThemeData(
        
      ),
    );
  }
}
