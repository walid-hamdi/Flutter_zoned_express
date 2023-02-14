import 'package:flutter/material.dart';

class CustomColors {
  static const Color lightPrimaryColor = Color(0xFF333333);
  static const Color darkPrimaryColor = Color(0xFF222222);
  static const Color lightAccentColor = Color(0xFFFFFFFF);
  static const Color darkAccentColor = Color(0xFF333333);
  static const Color lightTextColor = Color(0xFF333333);
  static const Color darkTextColor = Color(0xFFFFFFFF);
  static const Color lightBackgroundColor = Color(0xFFF6F6F6);
  static const Color darkBackgroundColor = Color(0xFF222222);

  static final Map<int, Color> lightColorCodes = {
    50: const Color(0xFF777777),
    100: const Color(0xFF888888),
    200: const Color(0xFF999999),
    300: const Color(0xFFAAAAAA),
    400: const Color(0xFFBBBBBB),
    500: lightPrimaryColor,
    600: const Color(0xFFDDDDDD),
    700: const Color(0xFFEEEEEE),
    800: const Color(0xFFFFFFFF),
    900: darkPrimaryColor,
  };

  static final Map<int, Color> darkColorCodes = {
    50: const Color(0xFF222222),
    100: const Color(0xFF111111),
    200: const Color(0xFF000000),
    300: const Color(0xFF000000),
    400: const Color(0xFF000000),
    500: darkPrimaryColor,
    600: const Color(0xFF000000),
    700: const Color(0xFF000000),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  };
}
