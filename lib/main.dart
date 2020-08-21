import 'dart:io';
import 'dart:ui';

import 'package:diaryschool/generated/i18n.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/models/time_of_day_adaper.dart';
import 'package:diaryschool/models/timetable_row.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/provider/TimetableProvider.dart';
import 'package:diaryschool/screens/failure/failure_screen.dart';
import 'package:diaryschool/screens/help/help_screen.dart';
import 'package:diaryschool/screens/main/main_screen.dart';
import 'package:diaryschool/screens/subjects/subjects_screen.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/screens/tasks/tasks_screen.dart';
import 'package:diaryschool/screens/teachers/teachers_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive
    ..registerAdapter(SubjectAdapter())
    ..registerAdapter(HomeworkAdapter())
    ..registerAdapter(TeacherAdapter())
    ..registerAdapter(TimetableRowAdapter())
    ..registerAdapter(TimeOfDayAdapter());

  final Box<Teacher> teachers = await Hive.openBox<Teacher>('teachers');
  final Box<Subject> subjects = await Hive.openBox<Subject>('subjects');
  final Box<Homework> homeworks = await Hive.openBox<Homework>('homeworks');
  final Box<TimetableRow> timetable =
      await Hive.openBox<TimetableRow>('timetable');
  // await homeworks.clear();
  // await subjects.clear();
  // await teachers.clear();
  // await timetable.clear();
  final Box settings = await Hive.openBox('settings');

  InAppPurchaseConnection.enablePendingPurchases();
  runApp(DiarySchoolApp(
    teachers: teachers,
    subjects: subjects,
    homeworks: homeworks,
    settings: settings,
    timetable: timetable,
  ));
}

class DiarySchoolApp extends StatelessWidget {
  final Box<Teacher> teachers;
  final Box<Subject> subjects;
  final Box<Homework> homeworks;
  final Box<TimetableRow> timetable;
  final Box settings;

  DiarySchoolApp({
    Key key,
    this.teachers,
    this.subjects,
    this.homeworks,
    this.settings,
    this.timetable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TeacherProvider>(
          create: (context) => TeacherProvider(teachers),
        ),
        ChangeNotifierProvider<SubjectProvider>(
          create: (context) => SubjectProvider(subjects),
        ),
        ChangeNotifierProvider<HomeworkProvider>(
          create: (context) => HomeworkProvider(homeworks),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider(settings),
        ),
        ChangeNotifierProvider<TimetableProvider>(
          create: (context) => TimetableProvider(timetable),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: [
            i18n,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Provider.of<SettingsProvider>(context).getLanguage,
          supportedLocales: i18n.supportedLocales,
          localeResolutionCallback: i18n.resolution(
            fallback: Provider.of<SettingsProvider>(context).getLanguage,
          ),
          title: 'Дневник',
          debugShowCheckedModeBanner: false,
          initialRoute: MainScreen.id,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child,
            );
          },
          routes: {
            MainScreen.id: (context) => MainScreen(),
            TeachersScreen.id: (context) => const TeachersScreen(),
            SubjectsScreen.id: (context) => const SubjectsScreen(),
            HelpScreen.id: (context) => const HelpScreen(),
            FailureScreen.id: (context) => FailureScreen(),
            TasksScreen.id: (context) => TasksScreen(),
          },
          darkTheme: ThemeData(
            scaffoldBackgroundColor: const Color(0xff424242),
            bottomAppBarColor: const Color(0xff424242),
            primarySwatch: kColorRed,
            cursorColor: kColorRed.shade700,
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: const TextStyle(
                color: Color(0xffE0E0E0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kColorRed.shade700,
                ),
              ),
              hintStyle: const TextStyle(
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
            buttonTheme: const ButtonThemeData(
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
              overline: const TextStyle(
                color: Color(0xffE0E0E0),
                fontSize: 14,
                letterSpacing: 1.25,
                fontWeight: FontWeight.w500,
              ),
              subtitle1: const TextStyle(
                color: Color(0xffE0E0E0),
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.15,
              ),
              subtitle2: const TextStyle(
                color: Color(0xffE0E0E0),
                fontSize: 14,
                fontWeight: FontWeight.w200,
                letterSpacing: 0.1,
              ),
              bodyText1: const TextStyle(
                color: Color(0xffE0E0E0),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              bodyText2: const TextStyle(
                color: Color(0xffE0E0E0),
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
            buttonBarTheme: const ButtonBarThemeData(
              buttonTextTheme: ButtonTextTheme.normal,
            ),
            cursorColor: kColorRed.shade700,
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
              overline: const TextStyle(
                color: kColorBlack,
                fontSize: 14,
                letterSpacing: 1.25,
                fontWeight: FontWeight.w500,
              ),
              subtitle1: const TextStyle(
                color: kColorBlack,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.15,
              ),
              subtitle2: const TextStyle(
                color: kColorBlack,
                fontSize: 14,
                fontWeight: FontWeight.w200,
                letterSpacing: 0.1,
              ),
              bodyText2: const TextStyle(
                color: kColorBlack,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            colorScheme: ColorScheme(
              primary: kColorRed.shade700,
              primaryVariant: kColorRed.shade700,
              onPrimary: kColorRed.shade300,
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
      },
    );
  }
}
