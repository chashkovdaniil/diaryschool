import 'package:diaryschool/pages/timetable_page/widgets/week_navigation_bar/week_navigation_bar.dart';
import 'package:flutter/material.dart';

class TimetablePage extends StatefulWidget {
  TimetablePage({Key key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.check_circle_outline),
          tooltip: 'Показать невыполненное',
          onPressed: () {
            // ToDo: переход на страницу несделанного
          },
        ),
        title: Text('27 Сентября 2020'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.calendar_today),
              tooltip: 'Выбрать дату',
              onPressed: () {
                // ToDo: выбор даты
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          WeekNavigationBar(),
        ],
      ),
    );
  }
}
