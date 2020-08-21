import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsProvider extends ChangeNotifier {
  Box _values;

  SettingsProvider(Box values) {
    _values = values;
  }

  TimeOfDay timeNotification() {
    try {
      return _values.get(
        'timeNotification',
        defaultValue: const TimeOfDay(
          hour: 0,
          minute: 0,
        ),
      ) as TimeOfDay;
    } catch (e) {
      rethrow;
    }
  }

  Future setTimeNotification(TimeOfDay val) async {
    try {
      await _values.put('timeNotification', val);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  bool turnNotification() {
    try {
      return _values.get('turnNotification', defaultValue: false) as bool;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> turningNotification(bool val) async {
    try {
      await _values.put('turnNotification', val);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, bool> get filter => {
        'teacher': _values.get(
          'filterTeacher',
          defaultValue: false,
        ) as bool,
        'time': _values.get(
          'filterTime',
          defaultValue: false,
        ) as bool,
        'route': _values.get(
          'filterRoute',
          defaultValue: false,
        ) as bool,
        'deadline': _values.get(
          'filterDeadline',
          defaultValue: false,
        ) as bool,
      };

  Future<bool> setFilter(Map<String, bool> filter) async {
    try {
      await _values.put('filterTeacher', filter['teacher']);
      await _values.put('filterTime', filter['time']);
      await _values.put('filterDeadline', filter['deadline']);
      await _values.put('filterRoute', filter['route']);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  int get getStartPage {
    return _values.get('startPage', defaultValue: 2) as int;
  }

  Future setStartPage(int index) async {
    try {
      await _values.put('startPage', index);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  bool get getFirstRunGradesPage {
    return _values.get('firstRunGradesPage', defaultValue: true) as bool;
  }

  Future<void> setFirstRunGradesPage() async =>
      await _values.put('firstRunGradesPage', false);

  bool get getFirstRunTasksPage {
    return _values.get('firstRunTasksPage', defaultValue: true) as bool;
  }

  Future<void> setFirstRunTasksPage() async =>
      await _values.put('firstRunTasksPage', false);

  bool get getFirstRunTimetablePage {
    return _values.get('firstRunTimetablePage', defaultValue: true) as bool;
  }

  Future<void> setFirstRunTimetablePage() async =>
      await _values.put('firstRunTimetablePage', false);

  bool get getFirstRunTaskPage {
    return _values.get('firstRunTaskPage', defaultValue: true) as bool;
  }

  Future<void> setFirstRunTaskPage() async =>
      await _values.put('firstRunTaskPage', false);

  Locale get getLanguage {
    List<String> deviceLanguage = Platform.localeName.split("_");
    List<String> locale = (_values.get(
      'language',
      defaultValue: deviceLanguage[0] + '-' + deviceLanguage[1],
    ) as String)
        .split('-');
    return Locale(locale[0], locale[1]);
  }

  Future<void> setLanguage(Locale locale) async {
    await _values.put(
        'language', locale.languageCode + '-' + locale.countryCode);
    notifyListeners();
  }
}
