import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime _date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime get date => _date;
  set date(DateTime date) {
    _date = date;
    notifyListeners();
  }

  DateTime get selectedDate => _selectedDate;
  set selectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
