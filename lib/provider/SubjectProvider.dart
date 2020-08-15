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
  List<Subject> get values {
    List<Subject> _subjects = [];
    _values.values.toList().asMap().forEach((key, value) {
      value.uid = key;
      _subjects.add(value);
    });
    return _subjects;
  }

  @override
  Future<bool> put(Subject subject) async {
    try {
      subject.uid == null
          ? await _values.add(subject)
          : await _values.putAt(subject.uid, subject);
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
