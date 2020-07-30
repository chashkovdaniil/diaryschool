import 'package:diaryschool/common_widgets/divider.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/screens/teachers/teacher_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

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
          ListView.separated(
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
                        subject: Subject(
                          title: 'Математика',
                          teacher: 1,
                        ),
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
                  'Математика',
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  '306, Галина Васильевна',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              );
            },
            separatorBuilder: (context, index) => const CustomDivider(
              padding: EdgeInsets.only(left: kDefaultPadding * 4 - 10),
            ),
            itemCount: 6,
          ),
        ],
      ),
    );
  }
}

class SubjectDialog extends StatefulWidget {
  Subject subject;
  SubjectDialog({
    Key key,
    this.subject,
  }) : super(key: key);

  @override
  _SubjectDialogState createState() => _SubjectDialogState();
}

class _SubjectDialogState extends State<SubjectDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Предмет'),
      content: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TextFormField(
            initialValue: widget.subject.title,
            decoration: InputDecoration(hintText: 'Название'),
            onChanged: (value) {
              setState(() {
                widget.subject.title = value;
              });
            },
          ),
          TextFormField(
            initialValue: widget.subject.title,
            decoration: InputDecoration(hintText: 'Кабинет или аудитория'),
            onChanged: (value) {
              setState(() {
                widget.subject.title = value;
              });
            },
          ),
          FlatButton(
            onPressed: () async {
              print(await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Row(
                    children: <Widget>[
                      Text('Выбрать учителя'),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return TeacherDialog(teacher: Teacher());
                            },
                          );
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  content: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      dense: true,
                      onTap: () => Navigator.of(context).pop(1),
                      title: Text(
                        'Ирина Генадьевна',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    itemCount: 1,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Закрыть'.toUpperCase()),
                    ),
                  ],
                ),
              ));
            },
            child: Text(
              widget.subject.teacher == null
                  ? 'Указать учителя'
                  : widget.subject.teacher.toString(),
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Отмена'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () => print(widget.subject.title),
          // child: Text('f')
          child: Text(widget.subject.title == null
              ? 'Добавить'.toUpperCase()
              : 'Сохранить'.toUpperCase()),
        ),
      ],
    );
  }
}
