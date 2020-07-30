import 'package:flutter/material.dart';

class CardGrades extends StatelessWidget {
  final String subject;
  final List grades;

  CardGrades({Key key, this.subject, this.grades}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            subject,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            grades.join(' '),
            style: Theme.of(context).textTheme.subtitle2,
          ),
          trailing: Text('4,5',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
        ),
        // Container(
        //   padding: EdgeInsets.all(kDefaultPadding),
        //   // margin: EdgeInsets.only(bottom: kDefaultPadding),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).colorScheme.surface,
        //     // border: Border(bottom: BorderSide(width: 1, color: Colors.black12))
        //     // borderRadius: kBorderRadius,
        //     // boxShadow: kDefaultShadow,
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text(
        //         subject,
        //         style: Theme.of(context).textTheme.headline6,
        //       ),
        //       Text(grades.join(' ')),
        //     ],
        //   ),
        // ),
        const Divider()
      ],
    );
  }
}
