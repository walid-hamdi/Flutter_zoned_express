import 'package:flutter/material.dart';

import './custom_colors.dart';

final ThemeData lightTheme = ThemeData(
  // primarySwatch: Colors.red,
  brightness: Brightness.light,
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
    primarySwatch: MaterialColor(
        CustomColors.lightPrimaryColor.value, CustomColors.lightColorCodes),
  ).copyWith(
    primary: CustomColors.lightPrimaryColor,
    secondary: CustomColors.lightAccentColor,
  ),
);

final ThemeData darkTheme = ThemeData(
  // primarySwatch: Colors.red,
  brightness: Brightness.dark,
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
    primarySwatch: MaterialColor(
        CustomColors.darkPrimaryColor.value, CustomColors.darkColorCodes),
  ).copyWith(
    primary: CustomColors.darkPrimaryColor,
    secondary: CustomColors.darkAccentColor,
  ),
);
