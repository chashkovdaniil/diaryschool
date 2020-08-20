import 'dart:developer';

import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/provider/SchoolProvider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeworkProvider extends ChangeNotifier
    implements SchoolProvider<Homework> {
  Box<Homework> _values;

  HomeworkProvider(Box<Homework> homeworks) {
    _values = homeworks;
  }

  @override
  List<Homework> get values {
    List<Homework> _result = [];
    _values.values.toList().asMap().forEach((key, value) {
      value.uid = key;
      _result.add(value);
    });
    // log('result '+_result[_result.length - 2].content);
    return _result;
  }

  @override
  Future<bool> delete(int index) async {
    try {
      await _values.deleteAt(index);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> put(Homework data) async {
    try {
      if (data.uid == null) {
        await _values.add(data);
      } else {
        log('put');
        await _values.put(data.uid, data);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
