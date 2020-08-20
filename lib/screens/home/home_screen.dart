import 'package:diaryschool/screens/home/widgets/menu_tile.dart';
import 'package:diaryschool/screens/settings/settings_screen.dart';
import 'package:diaryschool/screens/subjects/subjects_screen.dart';
import 'package:diaryschool/screens/teachers/teachers_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';

// TODO: добавить рекламу

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: <Widget>[
          // TODO: сделать поиск
          // IconButton(
          //   icon: Hero(
          //     tag: 'search',
          //     child: Icon(Icons.search),
          //   ),
          //   onPressed: () {
          //     return Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => SearchScreen(),
          //       ),
          //     );
          //   },
          // ),
          IconButton(
            icon: const Icon(
              Icons.sort,
              textDirection: TextDirection.rtl,
            ),
            onPressed: () {
              return Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: kDefaultPadding - 5,
          //     bottom: kDefaultPadding - 5,
          //   ),
          //   child: Text(
          //     'Дедлайны (5)',
          //     style: Theme.of(context).textTheme.overline,
          //   ),
          // ),
          // Container(
          //   padding: const EdgeInsets.only(left: 15),
          //   height: 150,
          //   child: ListView.builder(
          //       itemCount: 8,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (_, __) {
          //         return DeadlineTile(
          //           onTap: () {},
          //           title: 'Математика',
          //           deadline: DateTime(2020, 10, 10),
          //         );
          //       }),
          // ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding - 5),
            child: Text(
              'Меню',
              style: Theme.of(context).textTheme.overline,
            ),
          ),
          GridView(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: kDefaultPadding,
              mainAxisSpacing: kDefaultPadding,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // MenuTile(
              // onTap: () => Navigator.pushNamed(
              //   context,
              //   TeachersScreen.id,
              // ),
              //   icon: Icons.speaker_notes,
              //   title: 'Заметки',
              // ),
              MenuTile(
                onTap: () => Navigator.pushNamed(
                  context,
                  TeachersScreen.id,
                ),
                icon: Icons.people,
                title: 'Учителя',
              ),
              MenuTile(
                onTap: () => Navigator.pushNamed(
                  context,
                  SubjectsScreen.id,
                ),
                icon: Icons.list,
                title: 'Предметы',
              ),
              // MenuTile(
              // onTap: () => Navigator.pushNamed(
              //   context,
              //   HelpScreen.id,
              // ),
              //   icon: Icons.help_outline,
              //   title: 'Помощь',
              // ),
              // MenuTile(
              // onTap: () {
              //   return Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) => const ArticlesScreen(),
              //     ),
              //   );
              // },
              //   icon: Icons.art_track,
              //   title: 'Статьи',
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
