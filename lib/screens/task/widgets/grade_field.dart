
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GradeField extends StatefulWidget {
  final String grade;
  GradeField({Key key, this.grade}) : super(key: key);
  @override
  _GradeFieldState createState() => _GradeFieldState();
}

class _GradeFieldState extends State<GradeField> {
  @override
  Widget build(BuildContext context) {
    String grade;
    return AlertDialog(
      title: Text(tr('grade')),
      content: TextFormField(
        initialValue: widget.grade,
        maxLength: 2,
        decoration: InputDecoration(
          hintText: tr('rate'),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => grade = value.trim(),
        // decoration: InputDecoration(),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(tr('close')),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text(tr('done')),
          onPressed: () => Navigator.of(context).pop(grade),
        ),
      ],
    );
  }
}