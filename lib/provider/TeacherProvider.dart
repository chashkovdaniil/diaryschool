import 'package:diaryschool/models/teacher.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class TeacherProvider extends ChangeNotifier {
  Box<Teacher> _teachers;
  TeacherProvider(Box<Teacher> teachers) {
    _teachers = teachers;
  }
  // final List<Teacher> _teachers = Hive.box<Teacher>('teachers').values.toList();

  List<Teacher> get teachers => _teachers.values.toList();

  // Future add(Teacher teacher) async {
  //   try {
  //     await _teachers.add(teacher);
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future delete(int index) async {
    try {
      await _teachers.deleteAt(index);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future add(Teacher teacher,{int index}) async {
    try {
      index == null
          ? await _teachers.add(teacher)
          : await _teachers.putAt(index, teacher);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
