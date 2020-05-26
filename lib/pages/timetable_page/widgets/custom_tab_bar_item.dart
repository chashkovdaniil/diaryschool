import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class CustomTabBarItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final bool isCurrently;

  CustomTabBarItem({
    Key key,
    @required this.title,
    @required this.date,
    @required this.isCurrently,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrently ? kHeadline6Color : null,
        borderRadius: kButtonBorderRadius,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: isCurrently ? Colors.white : kBodyText2Color,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "${date.day}",
            style: TextStyle(
              color: isCurrently ? Colors.white : kHeadline6Color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
