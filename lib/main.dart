import 'dart:ui';

import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/help/help_screen.dart';
import 'package:diaryschool/screens/main/main_screen.dart';
import 'package:diaryschool/screens/subjects/subjects_screen.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/screens/teachers/teachers_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive
    ..registerAdapter(SubjectAdapter())
    ..registerAdapter(HomeworkAdapter())
    ..registerAdapter(TeacherAdapter());

  // await Hive.openBox('subjects');
  final Box<Teacher> teachers = await Hive.openBox<Teacher>('teachers');
  // await Hive.openBox('homeworks');

  InAppPurchaseConnection.enablePendingPurchases();
  runApp(DiarySchoolApp(teachers: teachers));
}

class DiarySchoolApp extends StatelessWidget {
  Box<Teacher> teachers;
  DiarySchoolApp({Key key, this.teachers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ValueListenableProvider(
        //   create: (context) => ValueNotifier(Hive.box<Teacher>('teachers').listenable().value),
        // ),
        ChangeNotifierProvider<TeacherProvider>(
          create: (context) => TeacherProvider(teachers),
        ),ChangeNotifierProvider<SubjectProvider>(
          create: (context) => SubjectProvider(),
        )
        // StreamProvider<BoxEvent>(
        //   create: (context) => Hive.box<Teacher>('teachers').watch(),
        // )
        // ValueListenableProvider<ValueListenable<Box<Subject>>>(
        //   create: (context) => ValueNotifier(
        //     Hive.box<Subject>('subjects').listenable(),
        //   ),
        // ),
        // ValueListenableProvider<ValueListenable<Box<Homework>>>(
        //   create: (context) => ValueNotifier(
        //     Hive.box<Homework>('homeworks').listenable(),
        //   ),
        // ),
      ],
      child: MaterialApp(
        title: 'Дневник',
        debugShowCheckedModeBanner: false,
        initialRoute: MainScreen.id,
        routes: {
          MainScreen.id: (context) => MainScreen(),
          TaskScreen.id: (context) => TaskScreen(),
          TeachersScreen.id: (context) => const TeachersScreen(),
          SubjectsScreen.id: (context) => const SubjectsScreen(),
          HelpScreen.id: (context) => const HelpScreen(),
        },
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff424242),
          bottomAppBarColor: const Color(0xff424242),
          primarySwatch: kColorRed,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
              color: Color(0xffE0E0E0),
            ),
            hintStyle: TextStyle(
              color: Color(0xffE0E0E0),
            ),
          ),
          buttonBarTheme: const ButtonBarThemeData(
            buttonTextTheme: ButtonTextTheme.accent,
          ),
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
            bodyText1: TextStyle(
              color: const Color(0xffE0E0E0),
              fontSize: 14,
              fontWeight: FontWeight.normal,
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
            onSecondary: const Color(0xff424242),
            brightness: Brightness.dark,
          ),
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: kBorderRadius,
            ),
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
            shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
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
      ),
    );
  }
}
