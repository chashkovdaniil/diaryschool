
import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:flutter/material.dart' show AlertDialog, BuildContext, FlatButton, InputDecoration, Key, Navigator, State, StatefulWidget, Text, TextFormField, TextInputType, Widget;

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
      title: Text(I18n.of(context).grade),
      content: TextFormField(
        initialValue: widget.grade,
        maxLength: 2,
        decoration: InputDecoration(
          hintText: I18n.of(context).rate,
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => grade = value.trim(),
        // decoration: InputDecoration(),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(I18n.of(context).close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text(I18n.of(context).done),
          onPressed: () => Navigator.of(context).pop(grade),
        ),
      ],
    );
  }
}