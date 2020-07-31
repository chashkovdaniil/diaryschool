import 'package:hive/hive.dart';

part 'subject.g.dart';
@HiveType(typeId: 2)
class Subject{
  @HiveField(0)
  String title;
  @HiveField(1)
  int teacher;
  @HiveField(2)
  String map;

  Subject({this.title, this.teacher});

  Subject.fromMap(Map<String, dynamic> e) {
    title = e['title'] as String;
    teacher = e['teacher'] as int;
    map = e['map'] as String;
  }
}