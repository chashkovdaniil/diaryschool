import 'package:flutter/cupertino.dart';

Future<dynamic> cupertinoPushWithArgs(
    {@required BuildContext context,
    @required Object arguments,
    @required Widget pushTo}) {
  return Navigator.of(context).push(
    CupertinoPageRoute(
      settings: RouteSettings(arguments: arguments),
      builder: (BuildContext context) {
        return pushTo;
      },
    ),
  );
}
