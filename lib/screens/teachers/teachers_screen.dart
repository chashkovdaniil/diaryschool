import 'package:diaryschool/common_widgets/divider.dart' show CustomDivider;
import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:diaryschool/models/teacher.dart' show Teacher;
import 'package:diaryschool/provider/TeacherProvider.dart' show TeacherProvider;
import 'package:diaryschool/screens/teachers/teacher_card.dart' show TeacherCard;
import 'package:diaryschool/screens/teachers/teacher_dialog.dart' show TeacherDialog;
import 'package:diaryschool/utilities/constants.dart' show kDefaultPadding;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' show AppBar, BuildContext, Center, EdgeInsets, FlatButton, Icon, Icons, Key, ListView, NeverScrollableScrollPhysics, Padding, Scaffold, SizedBox, State, StatefulWidget, Text, Theme, ValueKey, Widget, showDialog;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).teachers),
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
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                I18n.of(context).add.toUpperCase(),
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Consumer<TeacherProvider>(
            builder: (context, provider, child) {
              if (provider.values.isEmpty) {
                return Center(
                  child: Text(I18n.of(context).noTeachers),
                );
              }
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const CustomDivider(
                  padding: EdgeInsets.only(left: kDefaultPadding * 4 - 10),
                ),
                cacheExtent: 60,
                itemCount: provider.values.length,
                itemBuilder: (context, index) {
                  return TeacherCard(
                    key: ValueKey(index),
                    teacher: provider.values[index],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
