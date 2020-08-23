import 'package:edum/utilities/constants.dart';
import 'package:flutter/material.dart';

class DeadlineTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final DateTime deadline;

  DeadlineTile({
    Key key,
    this.title,
    this.deadline,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kDefaultPadding),
      child: InkWell(
        onTap: onTap,
        borderRadius: kBorderRadius,
        child: Ink(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: kBorderRadius,
            boxShadow: kDefaultShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(((deadline.millisecondsSinceEpoch -
                                DateTime.now().millisecondsSinceEpoch) /
                            1000 /
                            60 /
                            60 /
                            24)
                        .round()
                        .toString() +
                    ' дней'),
                const Text('Смотреть'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
