import 'package:diaryschool/common_widgets/card_widget.dart';
import 'package:diaryschool/common_widgets/custom_material_button.dart';
import 'package:diaryschool/data/models/homework.dart';
import 'package:diaryschool/data/models/timetable.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_bloc.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_event.dart';
import 'package:diaryschool/pages/timetable_page/widgets/custom_tab_bar.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/custom_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_state.dart';

class TimetablePage extends StatefulWidget {
  TimetablePage({Key key}) : super(key: key);
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final List<Timetable> timetable = [
    Timetable(id: 1, subject: 1, start: '8:00', end: '8:40'),
    Timetable(id: 2, subject: 2, start: '8:50', end: '9:30'),
    Timetable(id: 3, subject: 3, start: '9:40', end: '10:20'),
    Timetable(id: 4, subject: 4, start: '10:30', end: '11:10'),
    Timetable(id: 5, subject: 5, start: '11:20', end: '12:00'),
    Timetable(id: 6, subject: 6, start: '12:10', end: '12:50'),
  ];
  final List<Map<String, dynamic>> homeworks = [
    {
      'id': 1,
      'subject': 1,
      'idShedule': 2,
      'isDone': 0,
    },
    {
      'id': 2,
      'subject': 2,
      'content': 'Page 124 #3,33,3,311111111111111111',
      'idShedule': 1,
      'isDone': 0,
      'grade': 5,
    },
    {
      'id': 3,
      'subject': 3,
      'content':
          'Page 124 #3,33,3,3, ,kf,kf,ввввввввввввввввввввввввввввввввввввввввввввввввв,kf,kf,\nfkfkfk\nkffkdddddddddddddddddd',
      'idShedule': 3,
      'isDone': 0,
      'grade': 1,
    },
    {
      'id': 4,
      'subject': 4,
      'content': 'Page 124 #3,33,3,3',
      'deadline': 123456,
      'isDone': 1,
      'idShedule': 4,
      'grade': 2,
    },
    {
      'id': 4,
      'subject': 5,
      'content': 'Page 124 #3,33,3,3',
      'deadline': 123456,
      'idShedule': 5,
      'isDone': 0,
      'grade': 3,
    },
    {
      'id': 4,
      'subject': 5,
      'content': 'Page 124 #3,33,3,3',
      'deadline': 123456,
      'idShedule': 6,
      'isDone': 0,
    }
  ];
  final TimetableBloc _timetableBloc = TimetableBloc();

  @override
  void dispose() {
    _timetableBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BlocBuilder(
                  bloc: _timetableBloc,
                  condition: (prevState, currentState) {
                    return (currentState is InitialTimetableState ||
                            prevState is InitialTimetableState) ||
                        (currentState is WeekNavigationBarState &&
                            prevState is WeekNavigationBarState &&
                            prevState.firstDayOfCurrentWeek.month !=
                                currentState.firstDayOfCurrentWeek.month);
                  },
                  builder: (context, state) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "${kMonthIntToString[state.firstDayOfCurrentWeek.month]} ",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          '${state.firstDayOfCurrentWeek.year}',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                        offset: Offset(3, 4),
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    color: Colors.white,
                    highlightColor: const Color(0xffdfe3e4),
                    onPressed: () async {
                      DateTime selectedDay = await showDatePicker(
                        context: context,
                        initialDate: _timetableBloc.state.activeDay,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2150),
                      );
                      if (selectedDay != null) {
                        DateTime firstDayOfCurrentWeek = selectedDay
                            .add(Duration(days: -selectedDay.weekday + 1));
                        _timetableBloc.add(WeekNavigationBarEvent(
                          activeDay: selectedDay,
                          firstDayOfCurrentWeek: firstDayOfCurrentWeek,
                        ));
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Выбрать дату',
                      style: TextStyle(
                        color: kColorRed,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomTabBar(
            bloc: _timetableBloc,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              physics: const CustomScrollPhysics(),
              child: Column(
                children: timetable.map(
                  (e) {
                    return CardWidget(
                      homework: Homework.fromMap(
                          homeworks[int.parse(e.id.toString()) - 1]),
                      timetable: e,
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
