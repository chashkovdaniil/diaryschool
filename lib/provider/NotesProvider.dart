
import 'package:diaryschool/models/note.dart' show Note;
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:hive/hive.dart';

class NotesProvider extends ChangeNotifier {
  Box<Note> _box;

  NotesProvider(Box<Note> box) {
    _box = box;
  }

  Future<void> put(Note note) async {
    assert(note.title != null);
    assert(note.date != null);
    assert(note.content != null);
    note.uid ??= _box.values.toList().length;
    await _box.put(note.uid, note);
    notifyListeners();
  }

  Future<void> delete(int uid) async {
    await _box.deleteAt(uid);
    notifyListeners();
  }

  List<Note> get notes {
    List<Note> _notes = [];
    _box.values.toList().asMap().forEach((key, value) {
      value.uid = key;
      _notes.add(value);
    });

    return _notes;
  }
}
