extension DataString on DateTime {
  String get dmyStr {
    return '$day.$month.$year';
  }
}