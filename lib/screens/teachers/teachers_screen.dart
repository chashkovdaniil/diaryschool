import 'package:diaryschool/common_widgets/divider.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/teachers/teacher_card.dart';
import 'package:diaryschool/screens/teachers/teacher_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TeachersScreen extends StatefulWidget {
  static String id = 'taskScreen';
  const TeachersScreen({Key key}) : super(key: key);

  @override
  _TeachersScreenState createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Teacher> teachers = context.watch<TeacherProvider>().values;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('teachers')),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FlatButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return TeacherDialog(teacher: Teacher());
                  },
                );
              },
              icon: Icon(
                Icons.add,
                color: theme.primaryColor,
              ),
              label: Text(
                tr('add').toUpperCase(),
                style: theme.textTheme.button,
              ),
            ),
          ),
          const SizedBox(height: 16),
          teachers.isEmpty
              ? Center(child: Text(tr('noTeachers')))
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const CustomDivider(
                    padding: EdgeInsets.only(left: kDefaultPadding * 4 - 10),
                  ),
                  cacheExtent: 60,
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    return TeacherCard(
                      key: ValueKey(index),
                      teacher: teachers[index],
                    );
                  },
                ),
        ],
      ),
    );
  }
}
