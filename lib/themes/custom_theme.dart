import 'package:flutter/material.dart';

import './custom_colors.dart';

final ThemeData lightTheme = ThemeData(
  // primarySwatch: Colors.blue,
  brightness: Brightness.light,
  // accentColor: Colors.red,
  fontFamily: 'Georgia',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'MyCustomFont',
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 18.0,
      fontStyle: FontStyle.italic,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch:
        MaterialColor(CustomColors.primaryColor.value, CustomColors.colorCodes),
  ).copyWith(
    secondary: CustomColors.accentColor,
  ),
);

final ThemeData darkTheme = ThemeData(
  // primarySwatch: Colors.grey,
  brightness: Brightness.dark,
  // accentColor: Colors.yellow,
  fontFamily: 'Helvetica',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'MyCustomFont',
      fontSize: 74,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 20.0,
      fontStyle: FontStyle.italic,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch:
        MaterialColor(CustomColors.primaryColor.value, CustomColors.colorCodes),
  ).copyWith(
    secondary: CustomColors.accentColor,
  ),
);
