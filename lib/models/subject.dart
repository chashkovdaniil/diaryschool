import 'dart:developer';

import 'package:hive/hive.dart';

part 'subject.g.dart';

@HiveType(typeId: 1)
class Subject {
  @HiveField(0)
  String title;
  @HiveField(1)
  int teacher;
  @HiveField(2)
  String map;
  @HiveField(3)
  int uid;
  @HiveField(4)
  List<String> grades = [];

  Subject({this.title, this.teacher});

  double get score {
    if (grades.isNotEmpty && grades != null) {
      log(grades.toString());
      return grades.map(double.parse).reduce((value, element) => element + value) /
          grades.length;
    }
  }

  Subject.fromMap(Map<String, dynamic> e) {
    title = e['title'] as String;
    teacher = e['teacher'] as int;
    map = e['map'] as String;
    uid = e['uid'] as int;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'uid': uid,
      'teacher': teacher,
      'map': map,
      'grades': grades,
    };
  }
}
