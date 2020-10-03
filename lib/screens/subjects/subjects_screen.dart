import 'package:diaryschool/common_widgets/divider.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/subjects/subject_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectsScreen extends StatelessWidget {
  static String id = 'subjectsScreen';
  const SubjectsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Subject> subjects = context.watch<SubjectProvider>().values;
    List<Teacher> teachers = context.watch<TeacherProvider>().values;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('subjects')),
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
                    return SubjectDialog(subject: Subject());
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
          subjects.isEmpty
              ? Center(child: Text(tr('noSubjects')))
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  cacheExtent: 72,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return SubjectDialog(
                              subject: subjects[index],
                              index: index,
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
                        subjects[index].title.toString(),
                        style: theme.textTheme.headline6,
                      ),
                      subtitle: Text(
                        (subjects[index].map == null
                                ? ''
                                : '${subjects[index].map}, ') +
                            '${teachers[subjects[index].teacher].toString()}',
                        style: theme.textTheme.subtitle1,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          // TODO: сделать предупреждение, что есть дз с таким предметом или учителем
                          return Provider.of<SubjectProvider>(context,
                                  listen: false)
                              .delete(index);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const CustomDivider(
                    padding: EdgeInsets.only(left: kDefaultPadding * 4 - 10),
                  ),
                  itemCount: subjects.length,
                ),
        ],
      ),
    );
  }
}
