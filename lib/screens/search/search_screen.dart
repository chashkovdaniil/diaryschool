import 'package:flutter/material.dart' show AppBar, BuildContext, Hero, Icon, IconButton, Icons, InputBorder, InputDecoration, Key, ListTile, ListView, Navigator, Scaffold, StatelessWidget, Text, TextFormField, Widget;

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Hero(
            tag: 'search',
            child: Icon(Icons.search),
          ),
          title: TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Укажите запрос',
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.close,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: 60,
          itemExtent: 48,
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              onTap: () {},
              title: const Text('Ывау, ывау'),
            );
          },
        ));
  }
}
