import 'package:flutter/widgets.dart';

class CustomFonts {
  static const String primaryFont = 'Roboto';
  static const String secondaryFont = 'OpenSans';

  static TextStyle primaryTextStyle(
      double size, Color color, FontWeight weight) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }

  static TextStyle secondaryTextStyle(
      double size, Color color, FontWeight weight) {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }
}
