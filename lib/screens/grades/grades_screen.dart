import 'package:diaryschool/screens/grades/widgets/card_grades.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class GradesScreen extends StatelessWidget {
  GradesScreen({Key key}) : super(key: key);

  final List<Map<String, dynamic>> grades = [
    {
      'subject': 'Математика',
      'grades': [5,4,3,2,2,2,3,4,5,5,5,4,5,4,3,2,2,3,3,5,4,4,3,3,2,2]
    },
    {
      'subject': 'Русский язык',
      'grades': [5, 4, 3, 2, 2, 2, 3, 4, 5, 5, 5, 4]
    },
    {
      'subject': 'Математика',
      'grades': [5, 4, 3, 2, 2, 2, 3, 4, 5, 5, 5, 4]
    },
    {
      'subject': 'Математика',
      'grades': [5, 4, 3, 2, 2, 2, 3, 4, 5, 5, 5, 4]
    },
    {
      'subject': 'Математика',
      'grades': [5, 4, 3, 2, 2, 2, 3, 4, 5, 5, 5, 4]
    },
    {
      'subject': 'Математика',
      'grades': [5, 4, 3, 2, 2, 2, 3, 4, 5, 5, 5, 4]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Оценки'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_today),
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
                '1.02.2020 - 10.02.2020',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          ...grades
              .map((e) => CardGrades(
                  subject: e['subject'].toString(),
                  grades: e['grades'] as List))
              .toList(),
        ],
      ),
    );
  }
}
