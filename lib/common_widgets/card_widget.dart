import 'dart:ui';

import 'package:diaryschool/common_widgets/task_bottom_sheet.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return InkWell(
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
      onDoubleTap: () async {
        _homework.isDone = !_homework.isDone;
        bool _isDone = await Provider.of<HomeworkProvider>(
          context,
          listen: false,
        ).put(_homework);
        if (_isDone) {
          setState(() {});
          return;
        }
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
                          .values[_homework.subject]
                          .title, // _homework.subject делаем запрос в базу, чтобы получить название предмета
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    trailing: _homework.grade == null
                        ? null
                        : Text(
                            '${_homework.grade}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
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
                                (_homework.deadline != null &&
                                    _homework.isDone == false &&
                                    _homework.content != null &&
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
                                Provider.of<TeacherProvider>(context)
                                    .values[
                                        Provider.of<SubjectProvider>(context)
                                            .values[_homework.subject]
                                            .teacher]
                                    .toString(),
                              )
                            : const SizedBox.shrink(),
                        showRoute
                            ? _buildCardInfoItem(
                                Icons.place,
                                Provider.of<SubjectProvider>(context)
                                    .values[_homework.subject]
                                    .map,
                              )
                            : const SizedBox.shrink(),
                        _homework.deadline != null &&
                                _homework.isDone == false &&
                                _homework.content != null &&
                                showDeadline
                            ? _buildCardInfoItem(
                                Icons.timer,
                                getDeadline(_homework.deadline),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _homework.isDone
              ? Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          _homework.isDone
              ? Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width / 6,
                  child: Container(
                    transform: Matrix4.rotationZ(0.5),
                    child: Text(
                      '[ Сделано ]',
                      textScaleFactor: 2,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
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

  String getDeadline(DateTime deadline) {
    DateTime _currentDate = DateTime.now();
    Duration  _rest = _currentDate.difference(deadline);
    // int _years = deadline.year - _currentDate.year;
    // int _months = deadline.month - _currentDate.month;
    // int _days = deadline.day - _currentDate.day;

    // if (_years > 0) {
    //   _result += ' $_years года(лет)';
    // }
    
    // if (_months > 0) {
    //   _result += ' $_months мес.';
    // }
    
    // if (_days > 0) {
    //   _result += ' $_days дн.';
    // }

    return 'Осталось: ${_rest.inDays} дн.';
  }
}
