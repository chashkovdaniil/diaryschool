import 'package:hive/hive.dart';

part 'homework.g.dart';
@HiveType(typeId: 0)
class Homework {
  @HiveField(0)
  int subject;
  @HiveField(1)
  String content;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  List files;
  @HiveField(4)
  bool isDone;
  @HiveField(5)
  String grade;
  @HiveField(6)
  DateTime deadline;
  @HiveField(7)
  int uid;

  Homework({
    this.subject = 0,
    this.isDone = false,
    this.content,
    this.date,
    this.files,
    this.grade,
    this.deadline,
    this.uid,
  });
  
  Homework.fromMap(Map<String, dynamic> data) {
    uid = data['uid'] as int;
    subject = data['subject'] as int;
    isDone = data['isDone'] == 1;
    content = data['content'] as String;
    grade = data['grade'] as String;
    date = DateTime.fromMillisecondsSinceEpoch(data['subject'] as int);
    deadline = DateTime.fromMillisecondsSinceEpoch(data['subject'] as int);
    files = data['files'] as List;
  }
}
