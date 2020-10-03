import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/TextStyles.dart';
import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;

  MenuTile({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: kBorderRadius,
      child: Ink(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: kBorderRadius,
          boxShadow: kDefaultShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              size: 54,
            ),
            Text(
              title,
              style: theme.textTheme.headline6,
            ).button(),
          ],
        ),
      ),
    );
  }
}
