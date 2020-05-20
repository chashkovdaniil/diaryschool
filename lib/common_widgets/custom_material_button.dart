import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

Widget buildCustomMaterialButton(
    {@required Function onPressed, @required Widget child}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(
      borderRadius: kButtonBorderRadius,
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minWidth: 0,
    padding: EdgeInsets.zero,
    onPressed: () {
      onPressed();
    },
    child: child,
  );
}
