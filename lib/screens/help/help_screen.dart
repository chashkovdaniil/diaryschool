import 'package:edum/screens/help/q_screen.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static String id = 'helpScreen';
  const HelpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Помощь'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => QuestionScreen(),
              ),
            ),
            title: Text(
              'Как преодолет страх?',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
