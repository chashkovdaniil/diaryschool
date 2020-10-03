import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/screens/grades/widgets/card_grades.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class GradesScreen extends StatefulWidget {
  GradesScreen({Key key}) : super(key: key);

  @override
  _GradesScreenState createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  GlobalKey calendarKey = GlobalKey();
  OverlayEntry _overlayEntry;

  List<DateTime> rangeDate = [
    DateTime(DateTime.now().year, DateTime.now().month, 1),
    DateTime(DateTime.now().year, (DateTime.now().month + 1) % 13, 1),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Provider.of<SettingsProvider>(context).getFirstRunGradesPage &&
        Provider.of<int>(context) == 1) {
      _overlayEntry = firstRunStep1(context);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Overlay.of(context).insert(_overlayEntry);
      });
    }
  }

  @override
  void dispose() {
    _overlayEntry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    List<Homework> homeworks =
        context.watch<HomeworkProvider>().values.where((e) {
      if (e.date.millisecondsSinceEpoch <=
              rangeDate[1].millisecondsSinceEpoch &&
          e.date.millisecondsSinceEpoch >=
              rangeDate[0].millisecondsSinceEpoch) {
        return true;
      }
      return false;
    }).toList();

    List<Subject> subjects = context.watch<SubjectProvider>().values.map((s) {
      Subject subject = Subject.fromMap(s.toMap());
      homeworks.forEach((h) {
        if (h.subject == s.uid && h.grade != null) {
          subject.grades.add(h.grade);
        }
      });

      return subject;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('gradesNav')),
        actions: <Widget>[
          IconButton(
            key: calendarKey,
            onPressed: () async {
              DateTimeRange _range = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2019),
                lastDate: DateTime(2100),
              );
              if (_range != null) {
                rangeDate[0] = _range.start;
                rangeDate[1] = _range.end;
                setState(() {});
              }
            },
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(kDefaultPadding),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding),
            child: Center(
              child: Text(
                '${rangeDate[0].day}.${rangeDate[0].month}.${rangeDate[0].year}'
                ' - '
                '${rangeDate[1].day}.${rangeDate[1].month}.${rangeDate[1].year}',
                style: textTheme.headline6,
              ),
            ),
          ),
          if (subjects.isEmpty) Center(child: Text(tr('noGrades'))),
          ...subjects.map((e) {
            return CardGrades(
              subject: e.title,
              grades: e.grades,
              score: e.score,
            );
          }).toList(),
        ],
      ),
    );
  }

  OverlayEntry firstRunStep1(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tr('tipGrades1'),
                    textAlign: TextAlign.center,
                    style: textTheme.subtitle1,
                  ),
                  FlatButton(
                    onPressed: () {
                      _overlayEntry.remove();
                      _overlayEntry = firstRunStep2(context);
                      Overlay.of(context).insert(_overlayEntry);
                    },
                    child: Text(
                      tr('next'),
                      style: textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  OverlayEntry firstRunStep2(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: Colors.black.withOpacity(0.3),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: 32,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tr('tipGrades2'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      FlatButton(
                        onPressed: () {
                          Provider.of<SettingsProvider>(
                            context,
                            listen: false,
                          ).setFirstRunGradesPage();
                          _overlayEntry.remove();
                        },
                        child: Text(
                          tr('close'),
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
