import 'dart:ui' show ImageFilter;

import 'package:diaryschool/common_widgets/task_bottom_sheet.dart' show TaskBottomSheet;
import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:diaryschool/models/homework.dart' show Homework;
import 'package:diaryschool/provider/HomeworkProvider.dart' show HomeworkProvider;
import 'package:diaryschool/provider/SubjectProvider.dart' show SubjectProvider;
import 'package:diaryschool/utilities/constants.dart' show kBorderRadius, kDefaultShadow;
import 'package:flutter/material.dart' show BackdropFilter, BoxDecoration, BuildContext, ClipRRect, Colors, Column, Container, Divider, EdgeInsets, Expanded, Icon, IconData, Icons, Ink, InkWell, Key, ListTile, ListView, Matrix4, MediaQuery, NeverScrollableScrollPhysics, Padding, Positioned, RoundedRectangleBorder, Row, SizedBox, Stack, State, StatefulWidget, Text, TextOverflow, Theme, ValueKey, Widget, required, showModalBottomSheet;
import 'package:provider/provider.dart' show Provider;

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

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
          builder: (_context) => TaskBottomSheet(
            widget.homework.toMap(),
          ),
        );
      },
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
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                      Provider.of<SubjectProvider>(context)
                          .values[widget.homework.subject]
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
                    subtitle: widget.homework.content == null
                        ? null
                        : Text(
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
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
          if (widget.homework.isDone) ...[
            Positioned.fill(
              child: ClipRRect(
                child: BackdropFilter(
                  key: ValueKey(widget.homework.date.millisecondsSinceEpoch),
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(
                    key: ValueKey(widget.homework.date.millisecondsSinceEpoch),
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: MediaQuery.of(context).size.width / 6,
              child: Container(
                transform: Matrix4.rotationZ(0.5),
                child: Text(
                  '[ ${I18n.of(context).done} ]',
                  textScaleFactor: 2,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ],
        ],
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
