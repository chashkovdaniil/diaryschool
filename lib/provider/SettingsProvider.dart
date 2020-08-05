import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsProvider extends ChangeNotifier {
  Box _values;

  SettingsProvider(Box values) {
    _values = values;
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
          'filterDeadline',
          defaultValue: false,
        ) as bool,
        'deadline': _values.get(
          'filterRoute',
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
}
