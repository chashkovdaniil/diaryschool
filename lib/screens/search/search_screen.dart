import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Hero(
            tag: 'search',
            child: const Icon(Icons.search),
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
              title: Text('Ывау, ывау'),
            );
          },
        ));
  }
}
