import 'package:diaryschool/models/teacher.dart' show Teacher;
import 'package:diaryschool/provider/SchoolProvider.dart' show SchoolProvider;
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:hive/hive.dart';

class TeacherProvider extends ChangeNotifier
    implements SchoolProvider<Teacher> {
  Box<Teacher> _values;

  TeacherProvider(Box<Teacher> teachers) {
    _values = teachers;
  }

  @override
  List<Teacher> get values {
    List<Teacher> _teachers = [];
    _values.values.toList().asMap().forEach((key, value) {
      value.uid = key;
      _teachers.add(value);
    });
    return _teachers;
  }

  Teacher teacher(int uid) {
    try {
      return values[uid];
    } on RangeError {
      return Teacher(
        name: 'Не',
        middleName: 'cуществует',
      );
    }
  }

  @override
  Future<bool> put(Teacher teacher) async {
    try {
      teacher.uid == null
          ? await _values.add(teacher)
          : await _values.putAt(teacher.uid, teacher);
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
