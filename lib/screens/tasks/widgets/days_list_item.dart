import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class DaysListItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final bool isCurrently;

  DaysListItem({
    Key key,
    @required this.title,
    @required this.date,
    @required this.isCurrently,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrently ? kPrimaryColor : null,
        borderRadius: kBorderRadius,
        boxShadow: isCurrently ? kDefaultShadow : [],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: isCurrently
                  ? Colors.white
                  : Theme.of(context).colorScheme.onBackground,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            '${date.day}',
            style: TextStyle(
              color: isCurrently ? Theme.of(context).colorScheme.onPrimary : kColorRed.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
