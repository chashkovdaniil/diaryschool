// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_row.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimetableRowAdapter extends TypeAdapter<TimetableRow> {
  @override
  final int typeId = 3;

  @override
  TimetableRow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimetableRow(
      uid: fields[0] as int,
      subject: fields[1] as int,
      dayOfWeek: fields[2] as int,
      start: fields[3] as TimeOfDay,
      end: fields[4] as TimeOfDay,
    );
  }

  @override
  void write(BinaryWriter writer, TimetableRow obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.dayOfWeek)
      ..writeByte(3)
      ..write(obj.start)
      ..writeByte(4)
      ..write(obj.end);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimetableRowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
