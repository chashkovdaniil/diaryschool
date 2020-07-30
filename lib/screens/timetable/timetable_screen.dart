import 'package:diaryschool/common_widgets/card_widget.dart';
import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/screens/task/task_screen.dart';
import 'package:diaryschool/screens/timetable/widgets/days_list.dart';
import 'package:diaryschool/screens/timetable/bloc/timetable_bloc.dart';
import 'package:diaryschool/screens/timetable/widgets/filter_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class TimetableScreen extends StatefulWidget {
  TimetableScreen({Key key}) : super(key: key);
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final Map<String, bool> filter = {
    'teacher': true,
    'route': true,
    'deadline': true,
    'time': false,
  };

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
                      '${kMonthIntToString[state.firstDayOfCurrentWeek.month]} ',
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
            Consumer<Box<Homework>>(
              builder: (BuildContext context, Box<Homework> box, Widget child) {
                List<Homework> _homeworks = box.values.map((e) {
                  if (e.date == _timetableBloc.state.activeDay) {
                    return e;
                  }
                }).toList();
                return ListView.builder(
                  itemCount: _homeworks.length,
                  itemBuilder: (context, index) {
                    return CardWidget(
                      filter: filter,
                      homework: _homeworks[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TaskScreen()),
        ),
        child: Icon(Icons.add),
        tooltip: 'Добавить задание',
      ),
    );
  }
}
