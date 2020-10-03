import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryschool/utilities/TextStyles.dart';

class TaskBottomSheet extends StatefulWidget {
  final Map<String, dynamic> homework;

  TaskBottomSheet(this.homework, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'shortHomeworkDialog');
  Homework _homework;

  @override
  void initState() {
    _homework = Homework.fromMap(widget.homework);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    Subject subject =
        context.watch<SubjectProvider>().subject(_homework.subject);

    return BottomSheet(
      onClosing: () {},
      builder: (ctx) {
        return Container(
          color: theme.colorScheme.surface,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          subject.title,
                          maxLines: 1,
                          style: textTheme.headline6,
                        ),
                      ),
                      // const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_up,
                          color: theme.primaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => TaskScreen(
                                _homework.toMap(),
                              ),
                            ),
                          );
                        },
                      ),
                      const CloseButton(),
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultPadding / 10,
                  ),
                  TextFormField(
                    maxLines: 5,
                    initialValue: _homework.content,
                    decoration: InputDecoration(
                      labelText: tr('enterTask'),
                    ),
                    onChanged: (val) {
                      _homework.content = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return tr('fillField');
                      }
                      return null;
                    },
                    style: textTheme.subtitle2,
                  ),
                  FlatButton(
                    child: Text(tr('save')).button(),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        context.read<HomeworkProvider>().put(_homework);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
