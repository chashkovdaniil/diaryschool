import 'package:diaryschool/common_widgets/task_bottom_sheet.dart';
import 'package:diaryschool/data/models/homework.dart';
import 'package:diaryschool/data/models/timetable.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final Homework homework;
  final Timetable timetable;
  final Map<String, bool> filter;

  CardWidget({
    Key key,
    @required this.homework,
    @required this.timetable,
    @required this.filter,
  }) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    bool showTeacher = widget.filter['teacher'];
    bool showRoute = widget.filter['route'];
    bool showDeadline = widget.filter['deadline'];
    bool showTime = widget.filter['time'];

    Homework homework = widget.homework;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
            builder: (_context) => TaskBottomSheet(
              context: _context,
              homework: homework,
            ),
          );
        },
        onDoubleTap: () {
          setState(() {
            homework.isDone = !homework.isDone;
          });
        },
        borderRadius: kBorderRadius,
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: kBorderRadius,
            boxShadow: kDefaultShadow,
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Математика", // homework.subject делаем запрос в базу, чтобы получить название предмета
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: homework.grade == null
                    ? null
                    : Text(
                        '${homework.grade}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                subtitle: homework.content == null
                    ? null
                    : Text(
                        homework.content,
                        maxLines: 5,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 15,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    showTeacher || showRoute || showDeadline || showTime
                        ? const Divider(height: 1)
                        : const SizedBox.shrink(),
                    const SizedBox(height: 15),
                    showTeacher
                        ? _buildCardInfoItem(
                            Icons.person,
                            "Галина Васильевна",
                          )
                        : const SizedBox.shrink(),
                    showRoute
                        ? _buildCardInfoItem(
                            Icons.place,
                            "306, 3 этаж",
                          )
                        : const SizedBox.shrink(),
                    showTime
                        ? _buildCardInfoItem(
                            Icons.place,
                            "10:00 - 10:40",
                          )
                        : const SizedBox.shrink(),
                    homework.deadline == null &&
                            homework.isDone == false &&
                            homework.content != null &&
                            showDeadline
                        ? _buildCardInfoItem(
                            Icons.timer,
                            "Осталось 3 дня",
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              homework.content != null && homework.isDone == false
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        children: <Widget>[
                          const Divider(
                            height: 0,
                          ),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {
                                  setState(() {
                                    homework.isDone = true;
                                  });
                                },
                                child: Text(
                                  'Готово'.toUpperCase(),
                                  style: Theme.of(context).textTheme.button,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfoItem(IconData icon, String title) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon),
            const SizedBox(width: 5),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
