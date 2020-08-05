import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/screens/task/args.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskBottomSheet extends StatefulWidget {
  final BuildContext context;
  final Homework homework;
  final int index;

  TaskBottomSheet({Key key, this.context, this.homework, this.index})
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
                      Provider.of<SubjectProvider>(context)
                          .values[widget.homework.subject]
                          .title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_up),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => TaskScreen(
                              homework: widget.homework,
                              index: widget.index,
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
                  initialValue: widget.homework.content,
                  decoration: const InputDecoration(
                    labelText: 'Введите задание',
                  ),
                  onChanged: (val) {
                    widget.homework.content = val;
                  },
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                FlatButton(
                  child: Text(
                    'Сохранить'.toUpperCase(),
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {
                    // TODO: сделать валидацию
                    Provider.of<HomeworkProvider>(
                      context,
                      listen: false,
                    ).put(
                      widget.homework,
                      index: widget.index,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
