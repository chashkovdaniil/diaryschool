import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/SchoolProvider.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class TeacherProvider extends ChangeNotifier
    implements SchoolProvider<Teacher> {
  Box<Teacher> _values;

  TeacherProvider(Box<Teacher> teachers) {
    _values = teachers;
  }

  @override
  List<Teacher> get values => _values.values.toList();

  @override
  Future<bool> put(Teacher teacher, {int index}) async {
    try {
      index == null
          ? await _values.add(teacher)
          : await _values.putAt(index, teacher);
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
