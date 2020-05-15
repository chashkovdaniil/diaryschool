import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/custom_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Tasks extends StatelessWidget {
  Tasks({Key key}) : super(key: key);
  final List tasks = [
    {
      'title': 'Математика',
      'deadline': '3'
    },
    {
      'title': 'Обществознание',
      'deadline': '4'
    },
    {
      'title': 'Русский язык',
      'deadline': '3'
    },
    {
      'title': 'Mathematics',
      'deadline': '5'
    },
    {
      'title': 'Mathematics',
      'deadline': '1'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Задания',
              style: TextStyle(
                color: kPrimaryColorText,
                fontSize: 17,
                fontWeight: FontWeight.w700
              ),
            ),
            FlatButton(
              onPressed: () {
                // TODO: переход
              },
              child: Text(
                'Посмотреть все',
                style: TextStyle(
                  color: kPrimaryColorText,
                  fontSize: 13,
                  fontWeight: FontWeight.w400
                ),
              ),
            )
          ],
        ),
        Container(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 20),
            physics: const CustomScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 130,
                      padding: const EdgeInsets.all(10),
                      color: int.parse(tasks[index]['deadline'].toString()) <= 3 
                        ? const Color.fromARGB(255, 254, 245, 246)
                        : const Color.fromARGB(255, 244, 253, 248),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Deadline',
                            style: TextStyle(
                              color: kAccentColorText
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  color: int.parse(tasks[index]['deadline'].toString()) <= 3 
                                    ? const Color.fromARGB(255, 225, 84, 109)
                                    : const Color.fromARGB(255, 73, 208, 137),
                                  width: 10, 
                                  height: 10
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${tasks[index]["deadline"]} дня',
                                softWrap: true,
                              ),
                            ]
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '${tasks[index]["title"]}',
                            style: TextStyle(
                              color: kAccentColorText,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ]
                      ),
                    )
                  ),
                  const SizedBox(width: 15)
                ]
              );
            },
          ),
        )
      ],
    );
  }
}