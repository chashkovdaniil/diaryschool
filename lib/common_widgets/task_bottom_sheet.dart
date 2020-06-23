import 'package:diaryschool/data/models/homework.dart';
import 'package:diaryschool/data/models/subject.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/screens/task/args.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class TaskBottomSheet extends StatefulWidget {
  final BuildContext context;
  final Homework homework;
  final Subject subject;

  TaskBottomSheet({Key key, this.context, this.homework, this.subject})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (ctx) {
        String _task = 'Выбрать какую-нибудь фигню иначе получится не то.';
        return Container(
          color: Theme.of(context).colorScheme.surface,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Математика',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_up),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          TaskScreen.id,
                          arguments: TaskScreenArgs(
                            titleSubject: widget.homework.subject.toString(),
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
                  initialValue: _task,
                  decoration: const InputDecoration(
                    labelText: 'Введите задание',
                  ),
                  onChanged: (val) {
                    setState(() {
                      _task = val;
                    });
                  },
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                FlatButton(
                  child: Text(
                    'Сохранить'.toUpperCase(),
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
