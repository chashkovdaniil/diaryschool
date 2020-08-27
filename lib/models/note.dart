import 'package:flutter/foundation.dart' show required;
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 4)
class Note {
  @HiveField(0)
  int uid;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  DateTime date;

  Note({
    this.uid,
    @required this.title,
    @required this.content,
    @required this.date,
  })  : assert(uid is int),
        assert(title != null),
        assert(content != null),
        assert(date != null);

  Note.fromMap(Map<String, dynamic> map)
      : title = map['title'] as String,
        content = map['content'] as String,
        date = map['date'] as DateTime,
        uid = map['uid'] as int,
        assert(map != null);

  Map<String, dynamic> get toMap {
    return {
      'uid': uid,
      'title': title,
      'content': content,
      'date': date,
    };
  }
}
