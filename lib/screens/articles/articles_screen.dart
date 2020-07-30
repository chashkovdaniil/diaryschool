import 'package:diaryschool/screens/articles/article_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Статьи'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        itemCount: 10,
        itemBuilder: (context, id) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
              elevation: 10,
              child: InkWell(
                onTap: () {
                  return Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ArticleScreen(),
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: kBorderRadius,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding / 2),
                      child: Row(
                        children: <Widget>[
                          Text('Как перебороть страх?'),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
