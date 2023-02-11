import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/theme_notifier.dart';

void toggleTheme(BuildContext context) {
  Provider.of<ThemeNotifier>(context, listen: false).toggleDarkMode(context);
}

bool isDarkMode(BuildContext context) {
  return Provider.of<ThemeNotifier>(context).isDarkMode;
}

ThemeData getTheme(context) {
  return Provider.of<ThemeNotifier>(context).themeData;
}
