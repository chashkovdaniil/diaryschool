import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  CustomMaterialButton({Key key, @required this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: kBorderRadius,
      ),
      highlightColor: Colors.transparent,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: child,
    );
  }
}

// Widget buildCustomMaterialButton(
//     {@required VoidCallback onPressed, @required Widget child}) {
//   return MaterialButton(
//     shape: RoundedRectangleBorder(
//       borderRadius: kButtonBorderRadius,
//     ),
//     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     minWidth: 0,
//     padding: EdgeInsets.zero,
//     onPressed: onPressed,
//     child: child,
//   );
// }
