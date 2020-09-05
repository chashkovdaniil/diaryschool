import 'dart:ui';

import 'package:diaryschool/common_widgets/task_bottom_sheet.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
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

    TextTheme textTheme = Theme.of(context).textTheme;
    Subject subject =
        Provider.of<SubjectProvider>(context).subject(widget.homework.subject);

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
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 5,
                    bottom: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            subject
                                .title, // widget.homework.subject делаем запрос в базу, чтобы получить название предмета
                            maxLines: 1,
                            style: textTheme.headline6.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          if (widget.homework.grade != null)
                            Text(
                              '${widget.homework.grade}',
                              style: textTheme.headline4.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                        ],
                      ),
                      Text(
                        widget.homework.content,
                        maxLines: 5,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText2,
                      ),
                      Column(
                        children: <Widget>[
                          if (showTeacher ||
                              showRoute ||
                              (widget.homework.deadline != null &&
                                  widget.homework.isDone == false &&
                                  showDeadline)) ...[
                            const SizedBox(height: 10),
                            const Divider(height: 1),
                            const SizedBox(height: 10)
                          ],
                          if (showTeacher)
                            _buildCardInfoItem(
                              Icons.person,
                              widget.teacher,
                            ),
                          if (showRoute)
                            _buildCardInfoItem(
                              Icons.place,
                              subject.map,
                            ),
                          if (widget.homework.deadline != null &&
                              widget.homework.isDone == false &&
                              showDeadline)
                            _buildCardInfoItem(
                              Icons.timer,
                              getDeadline(widget.homework.deadline),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.homework.isDone)
                Container(
                  width: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: kDefaultShadow,
                  ),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        tr('done'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w200,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                  ),
                ),
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

    if (_rest.inDays < 0) return tr('expired');
    if (_rest.inDays == 0) {
      DateTime added =
          _currentDate.add(Duration(milliseconds: _rest.inMilliseconds + 1));

      if (added.day == _currentDate.day) return tr('today');
      return tr('tomorrow');
    }
    return '${tr('left')}: ${_rest.inDays} ${tr('days')}';
  }
}
