import 'package:diaryschool/screens/home/widgets/menu_tile.dart';
import 'package:diaryschool/screens/notes/notes_screen.dart';
import 'package:diaryschool/screens/settings/settings_screen.dart';
import 'package:diaryschool/screens/subjects/subjects_screen.dart';
import 'package:diaryschool/screens/teachers/teachers_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home')),
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
            icon: const Icon(Icons.settings),
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
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding - 5),
            child: Text(
              tr('menu'),
              style: theme.textTheme.overline,
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
              MenuTile(
                onTap: () => Navigator.pushNamed(
                  context,
                  TeachersScreen.id,
                ),
                icon: Icons.people,
                title: tr('teachers'),
              ),
              MenuTile(
                onTap: () => Navigator.pushNamed(
                  context,
                  SubjectsScreen.id,
                ),
                icon: Icons.list,
                title: tr('subjects'),
              ),
              MenuTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotesScreen(),
                  ),
                ),
                icon: Icons.note,
                title: tr('notes'),
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
