import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/provider/SchoolProvider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeworkProvider extends ChangeNotifier
    implements SchoolProvider<Homework> {
  Box<Homework> _values;

  HomeworkProvider(Box<Homework> homeworks) {
    _values = homeworks;
  }

  @override
  List<Homework> get values => _values.values.toList();
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
  Future<bool> put(Homework data, {int index}) async {
    try {
      index == null
          ? await _values.add(data)
          : await _values.putAt(index, data);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
