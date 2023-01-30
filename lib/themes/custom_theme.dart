import 'package:flutter/material.dart';

import './custom_colors.dart';

TextTheme textTheme = const TextTheme(
  headlineLarge: TextStyle(
      fontFamily: 'MyCustomFont', fontSize: 72, fontWeight: FontWeight.bold),
);

final ThemeData customTheme = ThemeData(
  textTheme: textTheme,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch:
        MaterialColor(CustomColors.primaryColor.value, CustomColors.colorCodes),
  ).copyWith(
    secondary: CustomColors.accentColor,
  ),
);
