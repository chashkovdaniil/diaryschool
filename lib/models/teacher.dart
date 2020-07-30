import 'package:hive/hive.dart';

part 'teacher.g.dart';
@HiveType(typeId: 0)
class Teacher {
  @HiveField(0)
  String name;
  @HiveField(1)
  String surname;
  @HiveField(2)
  String middleName;
  @HiveField(3)
  String email;
  @HiveField(4)
  int phone;
  @HiveField(5)
  List<int> subjects;

  Teacher({
    this.name,
    this.surname,
    this.middleName,
    this.email,
    this.phone,
    this.subjects,
  });

  Teacher.fromMap(Map<String,dynamic> data) {
    name = data['name'] as String;
    surname = data['surname'] as String;
    middleName = data['middleName'] as String;
    email = data['email'] as String;
    phone = data['phone'] as int;
    subjects = data['subjects'] as List<int>;
  }

  @override
  String toString(){
    return '$name $middleName';
  }
}
