import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class CurrentLesson extends StatelessWidget {
  CurrentLesson({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Сейчас',
              style: TextStyle(
                color:kPrimaryColorText,
                fontSize: 17,
                fontWeight: FontWeight.w700
              ),
            ),
            FlatButton(
              onPressed: () {
                // TODO: переход
              },
              child: Text(
                'Посмотреть все уроки',
                style: TextStyle(
                  color: kPrimaryColorText,
                  fontSize: 13,
                  fontWeight: FontWeight.w400
                ),
              ),
            )
          ],
        ),
        Column(
          children: <Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                color: const Color.fromARGB(255, 241, 240, 245),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Математика',
                      style: TextStyle(
                        color: kPrimaryColorText,
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    ),
                    Text(
                      'Закончится через 12 минут или в 15:00',
                      style: TextStyle(
                        color: kAccentColorText,
                        fontSize: 14
                      ),
                    ),
                  ]
                )
              )
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                color: const Color.fromARGB(255, 241, 240, 245),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Русский язык',
                      style: TextStyle(
                        color: kPrimaryColorText,
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    ),
                    Text(
                      'Начнется в 15:00',
                      style: TextStyle(
                        color: kAccentColorText,
                        fontSize: 14
                      ),
                    ),
                  ]
                )
              )
            )
          ]
        )
      ],
    );
  }
}