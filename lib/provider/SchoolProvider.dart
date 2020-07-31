import 'package:hive/hive.dart' show Box;

abstract class SchoolProvider<T> {
  Box<T> _values;

  SchoolProvider() {
    _init();
  }

  Future<void> _init();
  List<T> get values => _values.values.toList();
  Future<bool> put(T data, {int index});
  Future<bool> delete(int index);
}
