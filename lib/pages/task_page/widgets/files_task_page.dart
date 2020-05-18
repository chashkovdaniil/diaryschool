import 'package:diaryschool/pages/task_page/widgets/card_add_file.dart';
import 'package:diaryschool/pages/task_page/widgets/card_file.dart';
import 'package:diaryschool/pages/timetable_page/widgets/week_navigation_bar/custom_scroll_physics.dart';
import 'package:flutter/material.dart';

class FilesTaskPage extends StatelessWidget {
  final List<String> files;
  FilesTaskPage(this.files, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        physics: const CustomScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[]
          + files.map((String link) => CardFile(link)).toList()
          + [CardAddFile()],
      ),
    );
  }
}