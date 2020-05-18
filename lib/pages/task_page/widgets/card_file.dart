import 'package:flutter/material.dart';

class CardFile extends StatelessWidget {
  final String link;
  CardFile(this.link, {Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 90,
      margin: const EdgeInsets.only(right: 10),
      color: Colors.grey,
      child: Text(link),
    );
  }
}