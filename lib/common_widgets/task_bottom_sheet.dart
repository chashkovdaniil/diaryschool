import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskBottomSheet extends StatefulWidget {
  final BuildContext context;
  final Homework homework;

  TaskBottomSheet({Key key, this.context, this.homework}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'shortHomeworkDialog');

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
                      Text(
                        Provider.of<SubjectProvider>(context)
                            .values[widget.homework.subject]
                            .title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_up),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskScreen(homework: widget.homework),
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
                    initialValue: widget.homework.content,
                    decoration: const InputDecoration(
                      labelText: 'Введите задание',
                    ),
                    onChanged: (val) {
                      widget.homework.content = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Заполните поле!';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  FlatButton(
                    child: Text(
                      'Сохранить'.toUpperCase(),
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Provider.of<HomeworkProvider>(
                          context,
                          listen: false,
                        ).put(widget.homework);
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
