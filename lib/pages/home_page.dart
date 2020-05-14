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
      backgroundColor: kBackgroundColorAppBarPages,
      body: Stack(
        children: <Widget>[
          Container(
            color: kBackgroundColorHomePage,
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                Text(
                  'Hi Jack',
                  style: TextStyle(
                    color: kPrimaryColorText,
                    fontSize: 20,
                    fontWeight: FontWeight.w800
                  ),
                )
              ]
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 80),
            child: ClipRRect(
              borderRadius: borderRadiusBodyPages,
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
                        title: Text('Список предметов (9)'),
                        trailing: Icon(Linearicons.arrow_right),
                      ),
                      ListTile(
                        onTap: () {

                        },
                        title: Text('Учителя (10)'),
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
          )
        ]
      ),
    );
  }
}