import 'package:diaryschool/data/models/homework.dart';
import 'package:diaryschool/data/models/timetable.dart';
import 'package:diaryschool/pages/task_page.dart';
import 'package:diaryschool/pages/task_page/args.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final Homework homework;
  final Timetable timetable;

  CardWidget({
    Key key,
    @required this.homework,
    @required this.timetable,
  }) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    Homework homework = widget.homework;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            TaskPage.id,
            arguments: TaskPageArgs(
              titleSubject: homework.subject.toString(),
            ),
          );
        },
        onDoubleTap: () {
          setState(() {
            homework.isDone = !homework.isDone;
          });
        },
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: kCardWidgetBackgroundColor,
            borderRadius: kBorderRadiusCardWidget,
            boxShadow: [
              const BoxShadow(
                offset: Offset(3, 4),
                color: Color.fromRGBO(0, 0, 0, 0.16),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Математика", // homework.subject делаем запрос в базу, чтобы получить название предмета
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(width: 10),
                            homework.grade == null
                                ? const SizedBox.shrink()
                                : Text(
                                    '${homework.grade}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          homework.content ?? 'Нет задания',
                          maxLines: 5,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    // TODO: Прописать условия отображения разделителя
                    const Divider(),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: kBodyText2Color,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Галина Васильевна",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.place,
                          color: kBodyText2Color,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "306, 3 этаж",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    homework.deadline == null &&
                            homework.isDone == false &&
                            homework.content != null
                        ? Row(
                            children: <Widget>[
                              Icon(
                                Icons.timer,
                                color: kBodyText1Color,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Осталось 3 дня",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    homework.content != null && homework.isDone == false
                        ? const Divider()
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              homework.content != null && homework.isDone == false
                  ? Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          setState(() {
                            homework.isDone = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.check,
                              color: kBodyText2Color,
                            ),
                            Text(
                              'Отметить как выполненное',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
