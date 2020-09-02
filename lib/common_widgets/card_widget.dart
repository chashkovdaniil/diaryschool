import 'dart:ui';

import 'package:diaryschool/common_widgets/task_bottom_sheet.dart';
import 'package:diaryschool/generated/i18n.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatefulWidget {
  final Homework homework;
  final Map<String, bool> filter;
  final String teacher;

  CardWidget({
    Key key,
    @required this.homework,
    @required this.filter,
    @required this.teacher,
  })  : assert(homework != null),
        assert(filter != null),
        assert(teacher != null),
        super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    bool showTeacher = widget.filter['teacher'];
    bool showRoute = widget.filter['route'];
    bool showDeadline = widget.filter['deadline'];

    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
        builder: (_context) => TaskBottomSheet(
          widget.homework.toMap(),
        ),
      ),
      onDoubleTap: () async {
        widget.homework.isDone = !widget.homework.isDone;
        await Provider.of<HomeworkProvider>(
          context,
          listen: false,
        ).put(widget.homework);
        // setState(() {});
        // TODO: Показать диалог об ошибке, если есть
      },
      borderRadius: kBorderRadius,
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: kBorderRadius,
          boxShadow: kDefaultShadow,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: (widget.homework.isDone)
                      ? size.width - kDefaultPadding - 40
                      : size.width - kDefaultPadding,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          Provider.of<SubjectProvider>(context)
                              .subject(widget.homework.subject)
                              .title, // widget.homework.subject делаем запрос в базу, чтобы получить название предмета
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        trailing: widget.homework.grade == null
                            ? null
                            : Text(
                                '${widget.homework.grade}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                        subtitle: Text(
                          widget.homework.content,
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
                                  (widget.homework.deadline != null &&
                                      widget.homework.isDone == false &&
                                      widget.homework.content != null &&
                                      showDeadline)
                              ? 15
                              : 0,
                        ),
                        child: Column(
                          children: <Widget>[
                            showTeacher ||
                                    showRoute ||
                                    (widget.homework.deadline != null &&
                                        widget.homework.isDone == false &&
                                        widget.homework.content != null &&
                                        showDeadline)
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
                                    widget.teacher,
                                  )
                                : const SizedBox.shrink(),
                            showRoute
                                ? _buildCardInfoItem(
                                    Icons.place,
                                    Provider.of<SubjectProvider>(context)
                                        .subject(widget.homework.subject)
                                        .map,
                                  )
                                : const SizedBox.shrink(),
                            widget.homework.deadline != null &&
                                    widget.homework.isDone == false &&
                                    widget.homework.content != null &&
                                    showDeadline
                                ? _buildCardInfoItem(
                                    Icons.timer,
                                    getDeadline(widget.homework.deadline),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: kBorderRadius,
                ),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      'Готово',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                ),
              ),
              // if (widget.homework.isDone)
              //   Positioned(
              //     right: 0,
              //     bottom: 0,
              //     top: 0,
              //     child: Container(
              //       width: 40,
              //       decoration: BoxDecoration(
              //         color: Theme.of(context).primaryColor,
              //         borderRadius: kBorderRadius,
              //       ),
              //       child: Center(
              //         child: RotatedBox(
              //           quarterTurns: -1,
              //           child: Text(
              //             'Готово',
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.w200,
              //               color: Theme.of(context).colorScheme.background,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfoItem(IconData icon, String title) {
    return title == null || title == ''
        ? const SizedBox.shrink()
        : Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          );
  }

  String getDeadline(DateTime deadline) {
    DateTime _currentDate = DateTime.now();
    Duration _rest = deadline.difference(_currentDate);

    if (_rest.inDays == 0) {
      DateTime added =
          _currentDate.add(Duration(milliseconds: _rest.inMilliseconds + 1));

      if (added.day == _currentDate.day) return I18n.of(context).today;
      return I18n.of(context).tomorrow;
    }
    if (_rest.inDays < 0) return I18n.of(context).expired;
    return '${I18n.of(context).left}: ${_rest.inDays} ${I18n.of(context).days}';
  }
}
