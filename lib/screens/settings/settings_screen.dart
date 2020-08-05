import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'widgets/color_tile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        children: <Widget>[
          ListTile(
            title: Text('Напоминание'),
            trailing: Switch(
              value: false,
              onChanged: (val) {},
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Тема'),
                  content: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: <Widget>[
                      ColorTile(color: Colors.red),
                      ColorTile(color: Colors.green),
                      ColorTile(color: Colors.grey),
                      ColorTile(color: Colors.indigo),
                      ColorTile(color: Colors.yellow),
                      ColorTile(color: Colors.lime),
                      ColorTile(color: Colors.orange),
                      ColorTile(color: Colors.pink),
                      ColorTile(color: Colors.teal),
                      ColorTile(color: Colors.black),
                      ColorTile(color: Colors.cyan),
                      ColorTile(color: Colors.blue),
                      ColorTile(color: Colors.green),
                      ColorTile(color: Colors.green),
                      ColorTile(color: Colors.green),
                      ColorTile(color: Colors.green),
                      ColorTile(color: Colors.green),
                      ColorTile(color: Colors.green),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Закрыть'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
            title: Text('Сменить тему'),
            trailing: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: kBorderRadius,
              ),
            ),
          ),
          ListTile(
            title: Text('Темный режим'),
            trailing: Container(
              child: Text('Авто.'),
            ),
          ),
          ListTile(
            title: Text('Начальный экран'),
            trailing: Container(
              child: Text('Главная'),
            ),
          ),
          ListTile(
            title: Text('Оставить отзыв'),
          ),
          ListTile(
            title: Text('О приложении'),
          ),
        ],
      ),
    );
  }
}


