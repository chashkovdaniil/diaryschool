import 'package:diaryschool/common_widgets/card_widget.dart';
import 'package:diaryschool/pages/timetable_page/bloc/bloc.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_bloc.dart';
import 'package:diaryschool/pages/timetable_page/widgets/custom_tab_bar.dart';
import 'package:diaryschool/utilities/custom_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diaryschool/pages/timetable_page/bloc/timetable_state.dart';

class TimetablePage extends StatefulWidget {
  TimetablePage({Key key}) : super(key: key);
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final List<Map<String, dynamic>> homeworks = [
    {
      'id': 1,
      'title': 'Mathematics',
    },
    {'id': 2, 'title': 'Mathematics', 'homework': 'Page 124 #3,33,3,3'},
    {
      'id': 3,
      'title': 'Mathematics',
      'homework':
          'Page 124 #3,33,3,3, ,kf,kf,,kf,kf,fkfkfkkffkdddddddddddddddddd',
      'start': 123456789,
      'end': 223456789,
    },
    {
      'id': 4,
      'title': 'Mathematics',
      'homework': 'Page 124 #3,33,3,3',
      'start': 123456789,
      'end': 223456789,
      'deadline': '2020.04.04 17:00',
      'isDone': true
    },
    {
      'id': 4,
      'title': 'Mathematics',
      'homework': 'Page 124 #3,33,3,3',
      'start': 123456789,
      'end': 223456789,
      'deadline': '2020.04.04 17:00'
    },
    {
      'id': 4,
      'title': 'Mathematics',
      'homework': 'Page 124 #3,33,3,3',
      'start': 123456789,
      'end': 223456789,
      'deadline': '2020.04.04 17:00'
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text('Сен ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 37, 46, 101),
                        fontWeight: FontWeight.w700)),
                const Text('2020',
                    style: TextStyle(
                        color: Color.fromARGB(255, 37, 46, 101),
                        fontSize: 15,
                        fontWeight: FontWeight.w300))
              ]),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  // TODO: выбор даты
                },
                child: const Text('Выбрать дату',
                    style: TextStyle(
                        color: Color.fromARGB(255, 37, 46, 101),
                        fontSize: 15,
                        fontWeight: FontWeight.w300)))
          ],
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            color: Colors.white,
            child: Column(children: <Widget>[
                CustomTabBar(bloc: _timetableBloc,),
//              StreamBuilder<TimetableBloc, TimetableState>(
//                bloc: _timetableBloc.whereType<WeekNavigationBarState>(),
//                context
//                    .bloc<TimetableBloc>()
//                    .whereType<WeekNavigationBarState>()
//                builder: (context, state) {
//                  WeekNavigationBarState();
//                  mir.implements(WeekNavigationBarState, TimetableState);
//                  return CustomTabBar();
//                },
//                create: (BuildContext context) => context
//                    .bloc<TimetableBloc>()
//                    .whereType<WeekNavigationBarState>(),
//                child: CustomTabBar(),
//              ),
              const SizedBox(height: 10),
              Expanded(
                  child: SingleChildScrollView(
                physics: const CustomScrollPhysics(),
                child: Column(
                  children: homeworks.map((e) {
                    return CardWidget(
                      lesson: e['title'].toString(),
                      start: e['start'] == null
                          ? null
                          : int.parse(e['start'].toString()),
                      end: e['end'] == null
                          ? null
                          : int.parse(e['end'].toString()),
                      homework: e['homework'] == null
                          ? null
                          : e['homework'].toString(),
                      isDone: e['isDone'] == null ? null : e['isDone'] == 1,
                    );
                  }).toList(),
                ),
              ))
            ]),
          ),
        ));
  }
}
