import 'package:diaryschool/pages/home_page/widgets/current_lesson.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/custom_scroll_physics.dart';
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
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
            height: 80,
            color: kBackgroundColorAppBarHomePage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Hi Jack',
                      style: TextStyle(
                        color: kPrimaryColorText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                  ],
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
            margin: const EdgeInsets.only(top: 65),
            child: ClipRRect(
              borderRadius: kBorderRadiusBodyPages,
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: kBackgroundColorBodies,
                child: SingleChildScrollView(
                  physics: const CustomScrollPhysics(),
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