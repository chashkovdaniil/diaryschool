import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

extension ButtonText on Text {
  Text button() {
    return Text(
      data.toUpperCase(),
      textAlign: TextAlign.center,
      style: (style ?? const TextStyle()).copyWith(
        fontFamily: 'Raleway',
        color: kColorRed.shade700,
        fontSize: 14,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text buttonReverse() {
    return Text(
      data.toUpperCase(),
      textAlign: TextAlign.center,
      style: (style ?? const TextStyle()).copyWith(
        fontFamily: 'Raleway',
        color: Colors.white,
        fontSize: 14,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  Button(this.title, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: kBorderRadiusButton,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: kBorderRadiusButton,
            color: kColorRed.shade700,
            boxShadow: kDefaultShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16.0,
            ),
            child: Text(title).buttonReverse(),
          ),
        ),
      ),
    );
  }
}
