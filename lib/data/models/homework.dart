class Homework {
  int id;
  int idShedule;
  int subject;
  int grade;
  bool isDone;
  String content;
  List files;
  // int date;
  // bool common;

  Homework({
    this.id,
    // this.date,
    this.idShedule,
    this.subject,
    this.content,
    this.grade,
    this.isDone = false,
    /*this.common = false*/});

  factory Homework.fromMap(Map<String, dynamic> json) => Homework(
    id: json['id'] == null 
        ? null 
        : int.parse(json['id'].toString()),
    // date: int.parse(json['date'].toString()),
    idShedule: json['idShedule'] == null 
        ? null 
        : int.parse(json['idShedule'].toString()),
    subject: json['subject'] == null 
        ? null 
        : int.parse(json['subject'].toString()),
    content: json['content'] == null
        ? null
        : json['content'].toString(),
    grade: json['grade'] == null 
        ? null
        : int.parse(json['grade'].toString()),
    isDone: json['isDone'] == 1,
    // common: json['common'] == 1,
    // files: json['files']
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'idShedule': idShedule,
    'subject': subject,
    'content': content,
    // 'date': date,
    // 'grade': grade,
    'isDone': isDone ? 1 : 0,
    // 'common': common ? 1 : 0
  };
}
