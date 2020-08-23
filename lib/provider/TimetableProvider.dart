import 'dart:developer';

import 'package:edum/models/timetable_row.dart';
import 'package:edum/provider/SchoolProvider.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class TimetableProvider extends ChangeNotifier
    implements SchoolProvider<TimetableRow> {
  Box<TimetableRow> _values;

  TimetableProvider(Box<TimetableRow> timetable) {
    _values = timetable;
  }
  
  @override
  Future<bool> put(TimetableRow timetable) async {
    try {
      log(timetable.start.toString());
      timetable.uid == null
          ? await _values.add(timetable)
          : await _values.putAt(timetable.uid, timetable);
      notifyListeners();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(int index) async {
    try {
      await _values.deleteAt(index);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  List<TimetableRow> get values {
    List<TimetableRow> _timetable = [];
    _values.values.toList().asMap().forEach((key, value) {
      value.uid = key;
      _timetable.add(value);
    });
    return _timetable;
  }
}
