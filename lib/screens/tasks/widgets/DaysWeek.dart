import 'package:diaryschool/screens/tasks/provider/DateProvider.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaysWeek extends StatefulWidget {
  final DateTime currentDate;
  DaysWeek({
    Key key,
    @required this.currentDate,
  }) : super(key: key);

  @override
  _DaysWeekState createState() => _DaysWeekState();
}

class _DaysWeekState extends State<DaysWeek> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = widget.currentDate;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            context.read<DateProvider>().date = widget.currentDate.subtract(
              const Duration(days: 7),
            );
          },
          child: Ink(
            child: const Icon(Icons.arrow_back),
          ),
        ),
        ...List.generate(
          7,
          (index) {
            return Row(
              children: [
                buildDayWeek(
                  context,
                  currentDate.add(
                    Duration(days: index + 1 - currentDate.weekday),
                  ),
                ),
                const SizedBox(width: 2),
              ],
            );
          },
        ),
        InkWell(
          onTap: () {
            context.read<DateProvider>().date = widget.currentDate.add(
              const Duration(days: 7),
            );
          },
          child: Ink(
            child: const Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }

  Widget buildDayWeek(
    BuildContext context,
    DateTime date,
  ) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () {
        context.read<DateProvider>().selectedDate = date;
        setState(() {});
      },
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        padding: const EdgeInsets.all(kDefaultPadding / 3),
        decoration:
            date.compareTo(context.watch<DateProvider>().selectedDate) == 0
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.primaryColor,
                    boxShadow: kDefaultShadow,
                  )
                : null,
        child: Column(
          children: [
            Text(
              tr(shortDaysOfWeek[date.weekday - 1]),
              style: theme.textTheme.subtitle2.copyWith(
                fontWeight: FontWeight.w100,
                color: date.compareTo(
                            context.watch<DateProvider>().selectedDate) ==
                        0
                    ? theme.colorScheme.background
                    : null,
              ),
            ),
            Text(
              '${date.day}',
              style: theme.textTheme.subtitle2.copyWith(
                color: date.compareTo(
                            context.watch<DateProvider>().selectedDate) ==
                        0
                    ? theme.colorScheme.background
                    : theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}