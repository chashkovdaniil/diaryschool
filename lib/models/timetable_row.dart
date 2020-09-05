import 'package:flutter/material.dart' show TimeOfDay;
import 'package:hive/hive.dart';

part 'timetable_row.g.dart';

@HiveType(typeId: 3)
class TimetableRow {
  @HiveField(0)
  int uid;
  @HiveField(1)
  int subject;
  @HiveField(2)
  int dayOfWeek;
  @HiveField(3)
  TimeOfDay start;
  @HiveField(4)
  TimeOfDay end;

  TimetableRow({
    this.uid,
    this.subject,
    this.dayOfWeek,
    this.start,
    this.end,
  });

  TimetableRow.fromMap(Map<String, dynamic> map) {
    uid = map['uid'] as int;
    subject = map['subject'] as int;
    dayOfWeek = map['dayOfWeek'] as int;
    start = map['start'] as TimeOfDay;
    end = map['end'] as TimeOfDay;
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'subject': subject,
        'dayOfWeek': dayOfWeek,
        'start': start,
        'end': end,
      };
}
