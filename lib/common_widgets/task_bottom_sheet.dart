import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:diaryschool/models/homework.dart' show Homework;
import 'package:diaryschool/provider/HomeworkProvider.dart' show HomeworkProvider;
import 'package:diaryschool/provider/SubjectProvider.dart' show SubjectProvider;
import 'package:diaryschool/screens/task/task_screen.dart' show TaskScreen;
import 'package:diaryschool/utilities/constants.dart' show kDefaultPadding;
import 'package:flutter/material.dart' show BottomSheet, BuildContext, CloseButton, Column, Container, CrossAxisAlignment, EdgeInsets, Expanded, FlatButton, Form, FormState, GlobalKey, Icon, IconButton, Icons, InputDecoration, Key, MaterialPageRoute, MediaQuery, Navigator, Row, SingleChildScrollView, SizedBox, State, StatefulWidget, Text, TextFormField, Theme, Widget;
import 'package:provider/provider.dart';

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
    return BottomSheet(
      onClosing: () {},
      builder: (ctx) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
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
                          Provider.of<SubjectProvider>(context)
                              .values[_homework.subject]
                              .title,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      // const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_up),
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
                      labelText: I18n.of(context).enterTask,
                    ),
                    onChanged: (val) {
                      _homework.content = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return I18n.of(context).fillField;
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  FlatButton(
                    child: Text(
                      I18n.of(context).save.toUpperCase(),
                      style: Theme.of(context).textTheme.button,
                    ),
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
