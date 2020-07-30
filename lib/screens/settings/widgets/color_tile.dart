import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  final Color color;

  const ColorTile({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
    );
  }
}