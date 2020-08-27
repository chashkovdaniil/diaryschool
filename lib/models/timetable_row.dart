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
}
