import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CardGrades extends StatelessWidget {
  final String subject;
  final List grades;
  final double score;

  CardGrades({Key key, this.subject, this.grades, this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            subject,
            style: textTheme.headline6,
          ),
          subtitle: Text(
            grades.isEmpty ? tr('noGrades') : grades.join(' '),
            style: textTheme.subtitle2,
          ),
          trailing: Text((score ?? 0).toStringAsFixed(1),
              style: textTheme
                  .headline6
                  .copyWith(color: theme.colorScheme.onBackground)),
        ),
        const Divider()
      ],
    );
  }
}
