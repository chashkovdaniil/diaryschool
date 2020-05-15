import 'package:diaryschool/data/models/homework.dart';
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
  double _leftPadding = 20.0;
  double _startOffset;
  double _endOffset;
  bool _collapsed;

  @override
  void initState() {
    _startOffset = _leftPadding;
    _endOffset = _startOffset +
        (90 * widget.actions.length);
    _collapsed = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Homework homework = widget.homework;
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
          color: Colors.grey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            // border: Border.all(
            //   color: Colors.grey.shade200,
            //   width: 1,
            // ),
          ),
          margin: const EdgeInsets.only(top: 5, left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.actions.map((e) => e).toList(),
          ),
        ),
        GestureDetector(
          onHorizontalDragUpdate: (dragUpdateDetails) {
            setState(() {
              _leftPadding = getNextScrollPosition(
                  _leftPadding + dragUpdateDetails.delta.dx, false);
            });
          },
          onHorizontalDragEnd: (dragEndDetails) {
            setState(() {
              _leftPadding = getNextScrollPosition(_leftPadding, true);
            });
          },
          onHorizontalDragDown: (dragDownDetails) {},
          onDoubleTap: () {
            setState(() {
              homework.isDone = !homework.isDone;
            });
            // TODO: done
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            margin: EdgeInsets.only(top: 5, left: _leftPadding),
            padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Название предмета", // homework.subject делаем запрос в базу, чтобы получить название предмета
                      maxLines: 1,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 37, 46, 101),
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 10),
                    homework.isDone
                        ? Icon(Icons.done, color: Colors.green)
                        : const SizedBox.shrink()
                  ],
                ),
                homework.content == null
                    ? const SizedBox.shrink()
                    : Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Text(
                          homework.content,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 139, 139, 148),
                          ),
                        ),
                      ],
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
      if (((_leftPadding - (_collapsed ? _startOffset : _endOffset))).abs() >
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
  final String title;
  SlideAction({Key key, this.onTap, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: переход на страницу создания задания
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
        // child: Icon(
        //   iconData,
        //   size: kIconSlideActionSize,
        //   color: kSelectedItemColorOnBNB,
        // ),
      ),
    );
  }
}
