class Timetable {
  int id;
  int subject;
  // int weekday;
  String start;
  String end;

  Timetable({this.id, this.subject, /*this.weekday,*/ this.start, this.end});

  factory Timetable.fromMap(Map<String, dynamic> json) => Timetable(
        id: json['id'] == null ? null : int.parse(json['id'].toString()),
        // weekday: int.parse(json['weekday'].toString()),
        subject: int.parse(json['subject'].toString()),
        start: json['start'] == null ? null : json['start'].toString(),
        end: json['end'] == null ? null : json['end'].toString(),
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        // 'weekday': weekday,
        'subject': subject,
        'start': start,
        'end': end,
      };
}
