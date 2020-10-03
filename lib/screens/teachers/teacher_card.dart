import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/teachers/teacher_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
    ThemeData theme = Theme.of(context);
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
        style: theme.textTheme.subtitle1,
      ),
      subtitle: Text(
        tr('edit').toUpperCase(),
        style: theme.textTheme.button,
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
