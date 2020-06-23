import 'package:diaryschool/common_widgets/card_widget.dart';
import 'package:diaryschool/data/models/homework.dart';
import 'package:diaryschool/data/models/timetable.dart';
import 'package:diaryschool/screens/timetable/widgets/days_list.dart';
import 'package:diaryschool/screens/timetable/bloc/timetable_bloc.dart';
import 'package:diaryschool/screens/timetable/widgets/filter_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimetableScreen extends StatefulWidget {
  TimetableScreen({Key key}) : super(key: key);
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final List<Timetable> timetable = [
    Timetable(id: 1, subject: 1, start: '8:00', end: '8:40'),
    Timetable(id: 2, subject: 2, start: '8:50', end: '9:30'),
    Timetable(id: 3, subject: 3, start: '9:40', end: '10:20'),
    Timetable(id: 4, subject: 4, start: '10:30', end: '11:10'),
    Timetable(id: 5, subject: 5, start: '11:20', end: '12:00'),
    Timetable(id: 6, subject: 6, start: '12:10', end: '12:50'),
  ];
  final Map<String, bool> filter = {
    'teacher': true,
    'route': true,
    'deadline': true,
    'time': false,
  };
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
      appBar: AppBar(
        title: const Text('Расписание'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterDialog(
                  date: _timetableBloc.state.activeDay,
                  filter: filter,
                ),
              );
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Center(
                child: BlocBuilder(
                  bloc: _timetableBloc,
                  builder: (context, state) {
                    return Text(
                      "${kMonthIntToString[state.firstDayOfCurrentWeek.month]} ",
                      style: Theme.of(context).textTheme.headline6,
                    );
                  },
                ),
              ),
            ),
            DaysList(
              bloc: _timetableBloc,
            ),
            const SizedBox(height: 10),
            Column(
              children: timetable
                  .map((e) => CardWidget(
                        filter: filter,
                        homework: Homework.fromMap(
                            homeworks[int.parse(e.id.toString()) - 1]),
                        timetable: e,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
