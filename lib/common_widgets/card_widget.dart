import 'package:diaryschool/common_widgets/task_bottom_sheet.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final Homework homework;
  final Map<String, bool> filter;

  CardWidget({
    Key key,
    @required this.homework,
    @required this.filter,
  }) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  Homework _homework;

  @override
  void initState() {
    _homework = widget.homework;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool showTeacher = widget.filter['teacher'];
    bool showRoute = widget.filter['route'];
    bool showDeadline = widget.filter['deadline'];
    bool showTime = widget.filter['time'];

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
              homework: _homework,
            ),
          );
        },
        onDoubleTap: () {
          setState(() {
            _homework.isDone = !_homework.isDone;
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
                  'Математика', // _homework.subject делаем запрос в базу, чтобы получить название предмета
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: _homework.grade == null
                    ? null
                    : Text(
                        '${_homework.grade}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                subtitle: _homework.content == null
                    ? null
                    : Text(
                        _homework.content,
                        maxLines: 5,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: showTeacher ||
                            showRoute ||
                            (_homework.deadline != null &&
                                _homework.isDone == false &&
                                _homework.content != null &&
                                showDeadline) ||
                            showTime ? 15 : 0,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    showTeacher ||
                            showRoute ||
                            (_homework.deadline != null &&
                                _homework.isDone == false &&
                                _homework.content != null &&
                                showDeadline) ||
                            showTime
                        ? Column(
                          children: <Widget>[
                            const Divider(height: 1),
                            const SizedBox(height: 15)
                          ],
                        )
                        : const SizedBox.shrink(),
                    showTeacher
                        ? _buildCardInfoItem(
                            Icons.person,
                            'Галина Васильевна',
                          )
                        : const SizedBox.shrink(),
                    showRoute
                        ? _buildCardInfoItem(
                            Icons.place,
                            '306, 3 этаж',
                          )
                        : const SizedBox.shrink(),
                    showTime
                        ? _buildCardInfoItem(
                            Icons.access_time,
                            '10:00 - 10:40',
                          )
                        : const SizedBox.shrink(),
                    _homework.deadline != null &&
                            _homework.isDone == false &&
                            _homework.content != null &&
                            showDeadline
                        ? _buildCardInfoItem(
                            Icons.timer,
                            'Осталось 3 дня',
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              _homework.content != null && _homework.isDone == false
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
                                    _homework.isDone = true;
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
