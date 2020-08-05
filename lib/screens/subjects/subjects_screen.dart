import 'package:diaryschool/common_widgets/divider.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/subjects/subject_dialog.dart';
import 'package:diaryschool/screens/teachers/teacher_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectsScreen extends StatelessWidget {
  static String id = 'subjectsScreen';
  const SubjectsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Предметы'),
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
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Добавить предмет'.toUpperCase(),
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
          Consumer<SubjectProvider>(builder: (context, data, child) {
            return ListView.separated(
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
                          subject: data.values[index],
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
                    data.values[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    '${data.values[index].map}, '
                    '${Provider.of<TeacherProvider>(context).values[data.values[index].teacher].toString()}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
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
              itemCount: data.values.length,
            );
          }),
        ],
      ),
    );
  }
}
