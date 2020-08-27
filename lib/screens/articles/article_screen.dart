import 'package:diaryschool/utilities/constants.dart' show kDefaultPadding;
import 'package:flutter/material.dart' show AppBar, BuildContext, EdgeInsets, Icon, IconButton, Icons, Key, Padding, Scaffold, StatelessWidget, Text, Widget;
class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Как перебороть страх?'),
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