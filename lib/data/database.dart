import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';


import './models/homework.dart';
import './models/subject.dart';
import './models/timetable.dart';

class DBProvider {
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }
  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    if (Directory(databasesPath).existsSync()) {
      await Directory(databasesPath).create(recursive: true);
    }
    String path = join(databasesPath, "DB.db");

    // await deleteDatabase(path);

    return await openDatabase(path, version: 1,
      onOpen: (db) {}, 
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE subjects (id INTEGER PRIMARY KEY, title TEXT, teacher TEXT)");
        await db.execute('CREATE TABLE shedule ('
            'id INTEGER PRIMARY KEY,'
            'weekday int,'
            'week int,'
            'subject int)'
            'start text default "0:0",'
            'end text default "0:0")');
        await db.execute("CREATE TABLE homeworks ("
            "id INTEGER PRIMARY KEY,"
            "date int,"
            "idShedule int,"
            "subject int,"
            "content TEXT,"
            "files TEXT,"
            "grade int DEFAULT 0,"
            "isDone int DEFAULT 0,"
            "common int DEFAULT 0)");
    });
  }
  Future<List<Timetable>> getTimetable({int weekday}) async {
    final db = await database;
    var res = await db.query('shedule', where: 'weekday = ?', whereArgs: [weekday-1]);
    List<Timetable> list =  res.isNotEmpty ? res.map((data) => Timetable.fromMap(data)).toList() : [];
    return list;
  }

  Future timetable(Timetable timetable) async {
    final db = await database;
    if (timetable.id == null) {
      return await db.rawInsert("INSERT INTO shedule (weekday, subject, start, end) VALUES (?, ?, ?, ?)", 
        [timetable.weekday-1, timetable.subject, timetable.start, timetable.end]);
    }

    return await db.update('shedule', timetable.toMap(), where: 'id = ?', whereArgs: [timetable.id]);
  }
  Future deleteTimetable({int id, int weekday}) async {
    final db = await database;
    var homeworks = await db.query('homeworks', where: "idShedule = ?", whereArgs: [id]);

    if (homeworks.isNotEmpty) {
      homeworks.forEach((item){
        db.delete("homeworks", where: "id = ?", whereArgs: [item['id']]);
      });
    }

    var raw = db.delete('shedule', where: "id = ?", whereArgs: [id]);
    return {'query': raw, 'done': 1};
  }
  // Homeworks
  Future<List<Homework>> getNotDoneHomeworks() async {
    final db = await database;
    var res = await db.query('homeworks', where: 'isDone = 0 AND content != ""');
    List<Homework> list = res.isNotEmpty ? res.map((data) => Homework.fromMap(data)).toList() : [];
    return list;
  }
  Future<List<Homework>> getHomeWorks(int date, int common) async {
    final db = await database;
    var res = await db.query("homeworks", where: 'date = ? AND common = ?', whereArgs: [date, common]);
    List<Homework> list =  res.isNotEmpty ? res.map((data) => Homework.fromMap(data)).toList() : [];
    return list;
  }
  Future<Homework> getHomework({int date, int subject, int idTimetable}) async {
    final db = await database;
    var res = await db.query("homeworks", where: 'date = ? AND subject = ? AND idShedule = ?', whereArgs: [date, subject, idTimetable]);
    Homework homework = res.isNotEmpty ? res.map((data) => Homework.fromMap(data)).toList()[0] : Homework();
    return homework;
  }
  Future homework(Homework homework) async {
    final db = await database;
    if (homework.id == null) {
      int id = 1;
      var lastHomework = await db.rawQuery("SELECT * FROM homeworks ORDER BY id DESC LIMIT 1");
      if (lastHomework.isNotEmpty) {
        id = Homework.fromMap(lastHomework[0]).id++;
      }

      return db.rawInsert(
        "INSERT Into homeworks (id, content, idShedule, subject, date, grade, isDone, common)"
        " VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [id, homework.content, homework.idShedule, homework.subject, homework.date, homework.grade, homework.isDone, homework.common]
      );
    }
    return await db.update('homeworks', homework.toMap(), where: 'id = ?', whereArgs: [homework.id]);
  }
  // Subejcts
  Future<List<Subject>> getSubjects() async {
    final db = await database;
    var res = await db.query("subjects");
    List<Subject> list =  res.isNotEmpty ? res.map((data) => Subject.fromMap(data)).toList() : [];
    list.sort((a,b) => a.title.compareTo(b.title));
    return list;
  }
  Future<Subject> getSubject(int id) async{
    final db = await database;
    var res = await db.query("subjects", where: 'id = ?', whereArgs: [id]);
    List<Subject> list =  res.isNotEmpty ? res.map((data) => Subject.fromMap(data)).toList() : [];
    return list[0];
  }
  Future<Map<String, String>> subject(Subject subject) async {
    final db = await database;
    List subjects = await db.query('subjects', where: 'title = ?', whereArgs: [subject.title]);
    
    if (subjects.isEmpty) {
      if (subject.id == null) {
        await db.rawInsert(
          "INSERT Into subjects (title, teacher)"
          " VALUES (?, ?)",
          [subject.title, subject.teacher ?? '']
        );
        return {'done': '1', 'msg': 's1'};
      } else {
        await db.update("subjects", subject.toMap(), where: 'id = ?', whereArgs: [subject.id]);
        return {'done': '1', 'msg': 's2'};
      }
    }
    return {'done': '0', 'msg': 's0'};
  }
  Future deleteSubject(int id) async{
    final db = await database;
    
    var timetable = await db.query('shedule', where: "subject = ?", whereArgs: [id]);
    if (timetable.isNotEmpty) {
      for(var k = 0; k < timetable.length; k++){
        await DBProvider.db.deleteTimetable(id: Homework.fromMap(timetable[k]).id);
      }
    }
    return db.delete("subjects", where: "id = ?", whereArgs: [id]);
  }

  Future<List<Homework>> getGrades(int subject) async {
    final db = await database;
    var res = await db.query('homeworks', where: 'subject = ?', whereArgs: [subject]);
    List<Homework> list = res.isNotEmpty ? res.map( (data) => Homework.fromMap(data) ).toList() : [];
    return list;
  }

  Future close() async => (await database).close();

  Future importDB() async {
    bool permissionResult = await Permission.storage.request().isGranted;
    if (permissionResult){
      await close();
      final directory = join(await ExtStorage.getExternalStorageDirectory(), 'school');
      final path = join(directory, 'DB.db');
      final file = File(path);
      if (file.existsSync()) {
        final newDirectory = await getDatabasesPath();
        await file.copy(join(newDirectory, 'DB.db'));
        _database = await openDatabase(join(newDirectory, 'DB.db'));
      }
    }else{
      return ErrorDescription('Предоставьте права доступа!');
    }
  }
  Future exportDB() async {
    bool permissionResult = await Permission.storage.request().isGranted;
    if (permissionResult){
      await close();

      _database = await openDatabase(join(await getDatabasesPath(), 'DB.db'));
      final directory = await getDatabasesPath();
      final path = join(directory, 'DB.db');
      final file = File(path);
      final newDirectory = join(await ExtStorage.getExternalStorageDirectory(), 'school');

      if (!Directory(newDirectory).existsSync()) {
        await Directory(newDirectory).create(recursive: true);
      }

      await file.copy(join(newDirectory, 'DB.db'));
    }else{
      return ErrorDescription('Предоставьте права доступа!');
    }
  }
}
