import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  const CustomDivider({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Divider(
        height: 1,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
