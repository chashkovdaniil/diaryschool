import 'package:edum/utilities/constants.dart';
import 'package:flutter/material.dart';
class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Как перебороть страх?'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: (){},
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Text('Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem')
      ),
    );
  }
}