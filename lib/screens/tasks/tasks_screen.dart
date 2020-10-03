import 'package:diaryschool/common_widgets/card_widget.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/screens/tasks/provider/DateProvider.dart';
import 'package:diaryschool/screens/tasks/widgets/DaysWeek.dart';
import 'package:diaryschool/utilities/TextStyles.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/failure/failure_screen.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/screens/tasks/widgets/filter_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({Key key}) : super(key: key);
  static String id = '/tasksScreen';
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final DateTime firstDayOfCurrentDate =
      DateTime.now().add(Duration(days: -DateTime.now().weekday + 1));
  DateTime currentDate = DateTime.now();
  int currentWeekday;

  OverlayEntry _overlayEntry;

  @override
  void initState() {
    currentWeekday = currentDate.weekday;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (Provider.of<SettingsProvider>(context).getFirstRunTasksPage &&
        Provider.of<int>(context) == 2) {
      _overlayEntry = firstRun(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Overlay.of(context).insert(_overlayEntry);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, bool> _filter = Provider.of<SettingsProvider>(context).filter;
    List<Subject> subjects = context.watch<SubjectProvider>().values;
    List<Teacher> teachers = context.watch<TeacherProvider>().values;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('tasksNav')),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) {
                    return FailureScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.swap_horiz),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterDialog(
                  filter: _filter,
                ),
              );
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ChangeNotifierProvider<DateProvider>(
          create: (_) => DateProvider(),
          builder: (context, _) {
            DateProvider dateProvider = Provider.of<DateProvider>(context);

            List<Homework> _homeworks =
                context.watch<HomeworkProvider>().values.where((element) {
              if (element.date.year == dateProvider.selectedDate.year &&
                  element.date.month == dateProvider.selectedDate.month &&
                  element.date.day == dateProvider.selectedDate.day) {
                return true;
              }
              return false;
            }).toList();

            return Column(
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: theme.colorScheme.background,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              DateTime _date = await showDatePicker(
                                context: context,
                                initialDate: dateProvider.selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (_date != null) {
                                Provider.of<DateProvider>(
                                  context,
                                  listen: false,
                                ).selectedDate = _date;
                                Provider.of<DateProvider>(
                                  context,
                                  listen: false,
                                ).date = _date;
                              }
                            },
                            child: Ink(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: kDefaultPadding),
                              child: Center(
                                child: Text(
                                  '${tr(months[dateProvider.date.month - 1])}',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding / 2),
                            child: DaysWeek(currentDate: dateProvider.date),
                          ),
                          _homeworks.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Center(
                                    child: Text(
                                      tr('noTasks'),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                    top: kDefaultPadding / 2,
                                    left: kDefaultPadding / 2,
                                    right: kDefaultPadding / 2,
                                  ),
                                  child: Column(
                                    children: List.generate(
                                      _homeworks.length,
                                      (index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: kDefaultPadding / 2,
                                          ),
                                          child: CardWidget(
                                            homework: _homeworks[index],
                                            filter: _filter,
                                            teacher: teachers[subjects[
                                                        _homeworks[index]
                                                            .subject]
                                                    .teacher]
                                                .toString(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TaskScreen(
                          Homework(
                            date: dateProvider.selectedDate,
                            subject: defaultSubject(context),
                          ).toMap(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.add, color: theme.primaryColor),
                  label: Text(tr('add')).button(),
                ),
              ],
            );
          }),
    );
  }

  int defaultSubject(BuildContext context) {
    List<Subject> subjects = Provider.of<SubjectProvider>(context).values;
    // TODO: реализовать подачу предмета в зависимости от расписания
    if (subjects.isNotEmpty) {
      return 0;
    }
    return null;
  }

  OverlayEntry firstRun(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
        final List<String> tips = [
          tr('tipTasks1'),
          tr('tipTasks2'),
          tr('tipTasks3'),
          tr('tipTasks4'),
          tr('tipTasks5'),
        ];
        int currentTip = 0;
        ThemeData theme = Theme.of(context);
        return StatefulBuilder(builder: (context, setState) {
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
                      tips[currentTip],
                      textAlign: TextAlign.center,
                      style: theme.textTheme.subtitle1,
                    ),
                    FlatButton(
                      onPressed: () {
                        if (currentTip == tips.length - 1) {
                          Provider.of<SettingsProvider>(
                            context,
                            listen: false,
                          ).setFirstRunTasksPage();
                          _overlayEntry.remove();
                          return;
                        }
                        setState(() {
                          currentTip += 1;
                        });
                      },
                      child: Text(
                        (currentTip == tips.length - 1)
                            ? tr('close')
                            : tr('next'),
                        style: theme.textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}