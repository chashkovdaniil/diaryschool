import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ButtonText on Text {
  Text button() {
    return Text(
      data.toUpperCase(),
      textAlign: TextAlign.center,
      style: (style ?? const TextStyle()).copyWith(
        fontFamily: GoogleFonts.getFont('Raleway').fontFamily,
        color: kColorRed.shade700,
        fontSize: 14,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text buttonReverse() {
    return Text(
      data.toUpperCase(),
      textAlign: TextAlign.center,
      style: (style ?? const TextStyle()).copyWith(
        fontFamily: GoogleFonts.getFont('Raleway').fontFamily,
        color: Colors.white,
        fontSize: 14,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class Button extends StatelessWidget {
  @override
  Key key;
  String title;
  VoidCallback onTap;
  Button(this.title, {this.key, this.onTap});

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

class TextButton extends Text {
  TextButton(String data, {Key key})
      : super(
          data.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: GoogleFonts.getFont('Raleway').fontFamily,
            color: kColorRed.shade700,
            fontSize: 14,
            letterSpacing: 0.4,
            fontWeight: FontWeight.w500,
          ),
        );
}
