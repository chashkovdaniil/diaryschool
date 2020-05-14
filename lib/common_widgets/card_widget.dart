import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String lesson;
  final int start, end;
  final String homework;
  final bool isDone;
  final List<IconSlideAction> actions;

  CardWidget({
    Key key,
    @required this.lesson,
    this.start,
    this.end,
    this.homework,
    this.isDone,
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
        ((kIconSlideActionSize + 16.0 /*Padding*/) * widget.actions.length);
    _collapsed = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.start == null
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        '8:00',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 37, 46, 101),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
              widget.end == null
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: const Text(
                        '40 минут',
                        style: TextStyle(
                          color: Color.fromARGB(255, 139, 139, 148),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
            ],
          ),
          Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
//                  boxShadow: [
//
//                    const BoxShadow(
//                      color: Colors.black12,
//                    ),
//                    const BoxShadow(
//                      color: Colors.white,
//                      spreadRadius: -1.0,
//                      blurRadius: 6.0,
//                    ),
//
//                  ],
//                  color: Colors.white,
                color: kBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                height: 90.0,
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
                onHorizontalDragCancel: () {},
                onHorizontalDragStart: (dragStartDetails) {},
                onHorizontalDragEnd: (dragEndDetails) {
                  setState(() {
                    _leftPadding = getNextScrollPosition(_leftPadding, true);
                  });
                },
                onHorizontalDragDown: (dragDownDetails) {},
                child: AnimatedContainer(
                  height: 90.0,
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
                            widget.lesson,
                            maxLines: 1,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 37, 46, 101),
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 10),
                          widget.isDone == null
                              ? const SizedBox.shrink()
                              : Icon(Icons.done, color: Colors.green)
                        ],
                      ),
                      widget.homework == null
                          ? const SizedBox.shrink()
                          : Column(
                              children: <Widget>[
                                const SizedBox(height: 10),
                                Text(
                                  widget.homework,
                                  maxLines: 2,
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
          )
        ],
      ),
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

class IconSlideAction extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  IconSlideAction({Key key, this.iconData, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
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
