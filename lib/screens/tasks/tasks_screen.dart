import 'package:carousel_slider/carousel_slider.dart';
import 'package:diaryschool/common_widgets/card_widget.dart';
import 'package:diaryschool/generated/i18n.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/screens/tasks/provider/DateProvider.dart';
import 'package:diaryschool/utilities/TextStyles.dart';
import 'package:diaryschool/provider/HomeworkProvider.dart';
import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:diaryschool/screens/failure/failure_screen.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/screens/tasks/widgets/filter_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
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
  Map<String, bool> _filter;
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
    _filter = Provider.of<SettingsProvider>(context).filter;

    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).tasksNav),
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
            DateTime _selectedDate =
                Provider.of<DateProvider>(context).selectedDate;

            List<Homework> _homeworks =
                context.watch<HomeworkProvider>().values.where((element) {
              if (element.date.year == _selectedDate.year &&
                  element.date.month == _selectedDate.month &&
                  element.date.day == _selectedDate.day) {
                return true;
              }
              return false;
            }).toList();

            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    DateTime _date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
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
                    padding:
                        const EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: Center(
                      child: Text(
                        '${I18n.of(context).months[context.watch<DateProvider>().date.month - 1]}',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child:
                      DaysWeek(currentDate: context.watch<DateProvider>().date),
                ),
                Expanded(
                  child: _homeworks.isEmpty
                      ? Center(
                          child: Text(
                            I18n.of(context).noTasks,
                          ),
                        )
                      : Material(
                          color: Theme.of(context).colorScheme.background,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(
                              top: kDefaultPadding / 2,
                              left: kDefaultPadding / 2,
                              right: kDefaultPadding / 2,
                            ),
                            itemCount: _homeworks.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: kDefaultPadding / 2,
                                ),
                                child: CardWidget(
                                  homework: _homeworks[index],
                                  filter: _filter,
                                  teacher: Provider.of<TeacherProvider>(context)
                                      .teacher(_homeworks[index].subject)
                                      .toString(),
                                ),
                              );
                            },
                          ),
                        ),
                ),
                FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TaskScreen(
                          Homework(
                            date: _selectedDate,
                            subject: defaultSubject(context),
                          ).toMap(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                  label: Text(I18n.of(context).add).button(),
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
          I18n.of(context).tipTasks1,
          I18n.of(context).tipTasks2,
          I18n.of(context).tipTasks3,
          I18n.of(context).tipTasks4,
          I18n.of(context).tipTasks5,
        ];
        int currentTip = 0;
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tips[currentTip],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
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
                            ? I18n.of(context).close
                            : I18n.of(context).next,
                        style: Theme.of(context).textTheme.button,
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

class DaysWeek extends StatefulWidget {
  DateTime currentDate;
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
                    color: Theme.of(context).primaryColor,
                  )
                : null,
        child: Column(
          children: [
            Text(
              I18n.of(context).shortDaysOfWeek[date.weekday - 1],
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.w100,
                    color: date.compareTo(
                                context.watch<DateProvider>().selectedDate) ==
                            0
                        ? Theme.of(context).colorScheme.background
                        : null,
                  ),
            ),
            Text(
              '${date.day}',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: date.compareTo(
                                context.watch<DateProvider>().selectedDate) ==
                            0
                        ? Theme.of(context).colorScheme.background
                        : Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
// _homeworks.isNotEmpty && _homeworks != null
//     ? CarouselSlider.builder(
//         itemCount: _homeworks.length,
//         itemBuilder: (BuildContext context, int index) {
//           return CardWidget(
//             key: ValueKey(
//               _homeworks[index].date.millisecondsSinceEpoch,
//             ),
//             filter: _filter,
//             homework: _homeworks[index],
//             teacher: Provider.of<TeacherProvider>(context)
//                 .teacher(_homeworks[index].subject)
//                 .toString(),
//           );
//         },
//         options: CarouselOptions(
//           height: 260,
//           autoPlay: false,
//           enlargeCenterPage: true,
//           aspectRatio: 1.0,
//           initialPage: 0,
//           enableInfiniteScroll: false,
//           disableCenter: false,
//         ),
//       )
//     : Expanded(
//   child: Center(
//     child: Text(I18n.of(context).noTasks),
//   ),
// ),
