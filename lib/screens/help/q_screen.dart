import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Как преодолеть страх?')),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SelectableText(
          'loremipsum loremipsum loremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsum loremipsum loremipsum loremipsumloremipsumloremipsumloremipsum loremipsumloremipsum',
          
        ),
      ),
    );
  }
}
