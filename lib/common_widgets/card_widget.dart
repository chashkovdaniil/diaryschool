import 'package:diaryschool/data/models/homework.dart';
import 'package:diaryschool/pages/task_page/args.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final Homework homework;
  final List<SlideAction> actions;

  CardWidget({
    Key key,
    @required this.homework,
    @required this.actions,
  }) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  double _rightMargin = 20.0;
  double _startOffset;
  double _endOffset;
  bool _collapsed;

  @override
  void initState() {
    _startOffset = _rightMargin;
    _endOffset = _startOffset + (40 * widget.actions.length);
    _collapsed = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double height = 75;
    Homework homework = widget.homework;
    return Stack(
      children: <Widget>[
        Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: kBorderRadiusCardWidget,
          ),
          margin: const EdgeInsets.only(top: 5, left: 20, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.actions.map((e) => e).toList(),
          ),
        ),
        GestureDetector(
          onHorizontalDragUpdate: (dragUpdateDetails) {
            setState(() {
              _rightMargin = getNextScrollPosition(
                  _rightMargin - dragUpdateDetails.delta.dx, false);
            });
          },
          onHorizontalDragEnd: (dragEndDetails) {
            setState(() {
              _rightMargin = getNextScrollPosition(_rightMargin, true);
            });
          },
          onHorizontalDragDown: (dragDownDetails) {},
          onTap: () {
            Navigator.of(context).pushNamed(
              '/task',
              arguments: TaskPageArgs(titleSubject: homework.subject.toString()),
            );
          },
          onDoubleTap: () {
            setState(() {
              homework.isDone = !homework.isDone;
            });
            // TODO: done
          },
          child: AnimatedContainer(
            height: height,
            transform: Matrix4.translationValues(20 - _rightMargin, 0, 0),
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceInOut,
            margin: const EdgeInsets.only(top: 5, right: 20, left: 20.0),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 241, 240, 245),
              borderRadius: kBorderRadiusCardWidget,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Математика", // homework.subject делаем запрос в базу, чтобы получить название предмета
                      maxLines: 1,
                      style: TextStyle(
                          color: kPrimaryColorText,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    homework.grade == null
                        ? const SizedBox.shrink()
                        : Text('${homework.grade}',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700)),
                    const SizedBox(width: 10),
                    homework.isDone
                        ? Icon(Icons.done, color: Colors.green, size: 16)
                        : const SizedBox.shrink(),
                  ],
                ),
                Text(
                  homework.content ?? 'Нет задания',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 139, 139, 148),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double getNextScrollPosition(double offset, bool dragEnd) {
    if (dragEnd) {
      if (((_rightMargin - (_collapsed ? _startOffset : _endOffset))).abs() >
          (_endOffset - _startOffset) / 2) {
        _collapsed = !_collapsed;
        return _collapsed ? _startOffset : _endOffset;
      } else {
        return _collapsed ? _startOffset : _endOffset;
      }
    } else {
      if (offset < _startOffset - 10) {
        return _startOffset - 10;
      } else if (offset > _endOffset + 10) {
        return _endOffset + 10;
      } else {
        return offset;
      }
    }
  }
}

class SlideAction extends StatelessWidget {
  final Function onTap;
  // final String title;
  final IconData iconData;
  SlideAction({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: переход на страницу создания задания
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          iconData,
          size: kIconSlideActionSize,
          color: kSelectedItemColorOnBNB,
        ),
      ),
    );
  }
}
