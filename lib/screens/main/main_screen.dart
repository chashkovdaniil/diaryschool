import 'dart:async';

import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/screens/grades/grades_screen.dart';
import 'package:diaryschool/screens/home/home_screen.dart';
import 'package:diaryschool/screens/tasks/tasks_screen.dart';
import 'package:diaryschool/screens/timetable/timetable_page.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);
  static String id = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  InitializationSettings initializationSettings;

  final StreamController<int> _screenController = StreamController<int>();
  Stream<int> _screenStream;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(debugLabel: 'Home'),
    GlobalKey<NavigatorState>(debugLabel: 'Grades'),
    GlobalKey<NavigatorState>(debugLabel: 'Tasks'),
    GlobalKey<NavigatorState>(debugLabel: 'Timetable'),
  ];
  Widget navWidget({
    @required final int index,
    @required final Widget child,
  }) =>
      WillPopScope(
        child: child,
        onWillPop: () async {
          if (_navigatorKeys[index].currentState != null && _navigatorKeys[index].currentState.canPop()) {
            _navigatorKeys[index].currentState.pop();
            return false;
          }
          return true;
        },
      );

  List<Widget> _screens;

  Future selectNotification(String payload) async {
    if (payload != null) {
      _screenController.add(2);
      debugPrint('notification payload: ' + payload);
    }
  }

  @override
  void initState() {
    _screenStream = _screenController.stream.asBroadcastStream();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: (_, _q, _w, _e) async {});
    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    _screens = [
      navWidget(
        index: 0,
        child: HomeScreen(),
      ),
      navWidget(
        index: 1,
        child: GradesScreen(),
      ),
      navWidget(
        index: 2,
        child: Navigator(
          key: _navigatorKeys[2],
          onGenerateRoute: (RouteSettings _rs) {
            return MaterialPageRoute(
              builder: (context) {
                return TasksScreen();
              },
            );
          },
        ),
      ),
      navWidget(
        index: 3,
        child: TimetablePage(),
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _screenController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final List<BottomNavigationBarItem> bottomNavigationBarItems = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: Text(tr('homeNav')),
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.trending_up,
          size: 24,
        ),
        title: Text(tr('gradesNav')),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.format_list_bulleted),
        title: Text(tr('tasksNav')),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.calendar_today),
        title: Text(tr('timetableNav')),
      ),
    ];
    return StreamProvider(
      initialData: Provider.of<SettingsProvider>(context).getStartPage,
      create: (context) => _screenStream,
      builder: (context, snapshot) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: Provider.of<int>(context),
              children: _screens,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: theme.colorScheme.onSurface,
            backgroundColor: Colors.transparent,
            currentIndex: Provider.of<int>(context),
            onTap: (int value) {
              _screenController.add(value);
            },
            items: bottomNavigationBarItems,
          ),
        );
      },
    );
  }
}
