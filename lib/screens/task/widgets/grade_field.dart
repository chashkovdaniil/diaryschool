
import 'package:flutter/material.dart';

class GradeField extends StatefulWidget {
  String grade;
  GradeField({Key key, this.grade}) : super(key: key);
  @override
  _GradeFieldState createState() => _GradeFieldState();
}

class _GradeFieldState extends State<GradeField> {
  @override
  Widget build(BuildContext context) {
    String grade;
    return AlertDialog(
      title: Text('Оценка'),
      content: TextFormField(
        initialValue: widget.grade ?? '0',
        maxLength: 2,
        keyboardType: TextInputType.number,
        onChanged: (value) => grade = value.trim(),
        decoration: InputDecoration(),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Закрыть'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Готово'),
          onPressed: () => Navigator.of(context).pop(grade),
        ),
      ],
    );
  }
}