import 'package:hive/hive.dart' show Box;

abstract class SchoolProvider<T> {
  Box<T> _values;

  SchoolProvider(Box<T> box) {
    _values = box;
  }
  
  List<T> get values => _values.values.toList();
  Future<bool> put(T data);
  Future<bool> delete(int index);
}
