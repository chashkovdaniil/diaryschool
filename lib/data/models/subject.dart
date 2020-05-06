class Subject {
  int id;
  String title;
  String teacher = "";

  Subject({this.id, this.title, this.teacher});

  factory Subject.fromMap(Map<String, dynamic> json) => Subject(
    id: json['id'] == null ? null : int.parse(json['id'].toString()),
    title: json['title'].toString(),
    teacher: json['teacher'].toString()
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'teacher': teacher,
  };
}