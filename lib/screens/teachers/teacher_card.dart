import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:diaryschool/models/teacher.dart' show Teacher;
import 'package:diaryschool/provider/TeacherProvider.dart' show TeacherProvider;
import 'package:diaryschool/screens/teachers/teacher_dialog.dart' show TeacherDialog;
import 'package:diaryschool/utilities/constants.dart' show kBorderRadius;
import 'package:flutter/material.dart' show BoxDecoration, BuildContext, Colors, Container, Icon, IconButton, Icons, ListTile, StatelessWidget, Text, Theme, ValueKey, Widget, showDialog;
import 'package:provider/provider.dart';

class TeacherCard extends StatelessWidget {
  final Teacher teacher;
  @override
  final ValueKey<int> key;
  TeacherCard({
    this.key,
    this.teacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return TeacherDialog(
              teacher: teacher,
            );
          },
        );
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          color: Colors.grey,
        ),
      ),
      title: Text(
        teacher.toString(),
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subtitle: Text(
        I18n.of(context).edit.toUpperCase(),
        style: Theme.of(context).textTheme.button,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          return Provider.of<TeacherProvider>(context, listen: false)
              .delete(key.value);
        },
      ),
    );
  }
}
