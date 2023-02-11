import 'package:flutter/material.dart';

import 'custom_theme.dart';

class ThemeNotifier with ChangeNotifier {
  bool isDarkMode = false;
  ThemeData theme = lightTheme;

  void toggleDarkMode(BuildContext context) {
    isDarkMode = !isDarkMode;
    theme = isDarkMode ? darkTheme : lightTheme;
    notifyListeners();
  }

  ThemeData get themeData {
    return theme;
  }
}
