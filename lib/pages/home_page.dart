import 'package:diaryschool/pages/home_page/widgets/current_lesson.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/linearicons.dart';
import 'package:flutter/material.dart';

import 'home_page/widgets/tasks.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            color: kBackgroundColorHomePage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Hi Jack',
                  style: TextStyle(
                    color: kPrimaryColorText,
                    fontSize: 20,
                    fontWeight: FontWeight.w800
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Среда ', style: TextStyle(
                        color: kPrimaryColorText,
                        fontWeight: FontWeight.w700
                      )),
                      Text('10 сен', style: TextStyle(
                        color: kPrimaryColorText,
                        fontWeight: FontWeight.w300
                      ))
                    ],
                  ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 55),
            child: ClipRRect(
              borderRadius: kBorderRadiusBodyPages,
              child: Container(
                height: MediaQuery.of(context).size.height - 90,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: kBackgroundColorPages,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CurrentLesson(),
                      Tasks(),
                      ListTile(
                        onTap: () {

                        },
                        title: const Text('Список предметов (9)'),
                        trailing: Icon(Linearicons.arrow_right),
                      ),
                      ListTile(
                        onTap: () {

                        },
                        title: const Text('Учителя (10)'),
                        trailing: Icon(Linearicons.arrow_right),
                      )
                      // FlatButton(
                      //   onPressed: () {

                      //   },
                      //   child: Text('Список предметов'),
                      // )
                    ],
                  ),
                ),
              )
            ),
          ),
        ]
      )
    );
  }
}