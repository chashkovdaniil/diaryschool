import 'dart:developer';

import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/provider/SchoolProvider.dart';
import 'package:hive/hive.dart';
import 'package:flutter/widgets.dart';

class SubjectProvider extends ChangeNotifier
    implements SchoolProvider<Subject> {
  Box<Subject> _values;

  SubjectProvider(Box<Subject> box) {
    _values = box;
  }

  @override
  List<Subject> get values => _values.values.toList();

  @override
  Future<bool> put(Subject subject, {int index}) async {
    try {
      index == null
          ? await _values.add(subject)
          : await _values.putAt(index, subject);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
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
}
