import 'package:carousel_slider/carousel_slider.dart' show CarouselOptions, CarouselSlider;
import 'package:diaryschool/common_widgets/card_widget.dart' show CardWidget;
import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:diaryschool/models/homework.dart' show Homework;
import 'package:diaryschool/models/subject.dart' show Subject;
import 'package:diaryschool/provider/HomeworkProvider.dart' show HomeworkProvider;
import 'package:diaryschool/provider/SettingsProvider.dart' show SettingsProvider;
import 'package:diaryschool/provider/SubjectProvider.dart' show SubjectProvider;
import 'package:diaryschool/provider/TeacherProvider.dart' show TeacherProvider;
import 'package:diaryschool/screens/failure/failure_screen.dart' show FailureScreen;
import 'package:diaryschool/screens/task/task_screen.dart' show TaskScreen;
import 'package:diaryschool/screens/tasks/widgets/filter_dialog.dart' show FilterDialog;
import 'package:diaryschool/utilities/constants.dart' show kDefaultPadding;
import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart' show AppBar, BorderRadius, BoxDecoration, BuildContext, Center, Colors, Column, Container, EdgeInsets, Expanded, FlatButton, Icon, IconButton, Icons, Key, MainAxisAlignment, MainAxisSize, MaterialPageRoute, Navigator, Overlay, OverlayEntry, Row, Scaffold, SizedBox, Slider, Spacer, State, StatefulBuilder, StatefulWidget, Text, TextAlign, Theme, ValueKey, Widget, showDatePicker, showDialog;
import 'package:flutter/rendering.dart' show BorderRadius, BoxDecoration, EdgeInsets, MainAxisAlignment, MainAxisSize, TextAlign;
import 'package:flutter/scheduler.dart' show SchedulerBinding;
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
    final List<String> daysOfWeek = [
      I18n.of(context).mon,
      I18n.of(context).tues,
      I18n.of(context).wed,
      I18n.of(context).thurs,
      I18n.of(context).fri,
      I18n.of(context).sat,
      I18n.of(context).sun
    ];
    List<Homework> _homeworks =
        context.watch<HomeworkProvider>().values.where((element) {
      if (element.date.year == currentDate.year &&
          element.date.month == currentDate.month &&
          element.date.day == currentDate.day) {
        return true;
      }
      return false;
    }).toList();
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
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          _homeworks.isNotEmpty && _homeworks != null
              ? CarouselSlider.builder(
                  itemCount: _homeworks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardWidget(
                      key: ValueKey(
                        _homeworks[index].date.millisecondsSinceEpoch,
                      ),
                      filter: _filter,
                      homework: _homeworks[index],
                      teacher: Provider.of<TeacherProvider>(context)
                          .teacher(_homeworks[index].subject)
                          .toString(),
                    );
                  },
                  options: CarouselOptions(
                    height: 260,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    disableCenter: false,
                  ),
                )
              : Expanded(
                              child: Center(
                    child: Text(I18n.of(context).noTasks),
                  ),
              ),
          const Spacer(),
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskScreen(
                    Homework(
                      date: currentDate,
                      subject: defaultSubject(context),
                    ).toMap(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: Text(I18n.of(context).add),
          ),
          Container(
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.only(
              left: kDefaultPadding / 2,
              right: kDefaultPadding / 2,
              top: kDefaultPadding + 10,
              bottom: 5,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${daysOfWeek[currentDate.weekday - 1]} - ${currentDate.day}',
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        DateTime _date = await showDatePicker(
                          context: context,
                          initialDate: currentDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (_date != null) currentDate = _date;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Slider.adaptive(
                  min: 1,
                  max: 7,
                  divisions: 6,
                  label: daysOfWeek[currentDate.weekday - 1],
                  value: currentDate.weekday + .0,
                  onChanged: (value) {
                    setState(() {
                      currentDate = currentDate.add(
                        Duration(
                          days: -(currentDate.weekday - value.round()),
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int defaultSubject(BuildContext context) {
    List<Subject> subjects = Provider.of<SubjectProvider>(context).values;
    // TODO: реализовать подачу предмета в зависимости от расписания
    if (subjects.isNotEmpty) {
      return 0;
    }
    return subjects.length;
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
