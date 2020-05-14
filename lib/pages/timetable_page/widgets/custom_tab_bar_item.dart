import 'package:flutter/material.dart';

class CustomTabBarItem extends StatelessWidget {
  final String title;
  final DateTime date;
  // final DateTime currentDate;
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
        color: isCurrently ? const Color.fromARGB(255, 61, 48, 193) : null,
        borderRadius: BorderRadius.circular(7)),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style:  TextStyle(
              color: isCurrently
                ? Colors.white
                : const Color.fromARGB(255, 139, 139, 148),
              fontSize: 15,
              fontWeight: FontWeight.w300),
          ),
          Text(
            "${date.day}",
            style:  TextStyle(
              color: isCurrently
                ? Colors.white
                : const Color.fromARGB(255, 37, 46, 101),
              fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}