import 'package:diaryschool/screens/home/widgets/deadline_tile.dart';
import 'package:diaryschool/screens/home/widgets/menu_tile.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding- 5,
                bottom: kDefaultPadding - 5,
              ),
              child: Text(
                'Дедлайны (5)',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              height: 150,
              child: ListView.builder(
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, __) {
                    return DeadlineTile(
                      onTap: () {},
                      title: 'Математика',
                      deadline: DateTime(2020, 10, 10),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding - 5),
              child: Text(
                'Меню',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      MenuTile(
                        onTap: () {},
                        icon: Icons.people,
                        title: 'Учителя',
                      ),
                      SizedBox(width: kDefaultPadding),
                      MenuTile(
                        onTap: () {},
                        icon: Icons.list,
                        title: 'Предметы',
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding),
                  Row(
                    children: <Widget>[
                      MenuTile(
                        onTap: () {},
                        icon: Icons.help_outline,
                        title: 'Помощь',
                      ),
                      SizedBox(width: kDefaultPadding),
                      MenuTile(
                        onTap: () {},
                        icon: Icons.art_track,
                        title: 'Статьи',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
