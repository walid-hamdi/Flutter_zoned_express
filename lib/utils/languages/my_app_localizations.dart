import "package:flutter/material.dart";

class MyAppLocalizations {
  MyAppLocalizations(this.locale);

  final Locale locale;

  static MyAppLocalizations? of(BuildContext context) {
    return Localizations.of<MyAppLocalizations>(context, MyAppLocalizations);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'My App',
      'language': 'Language',
      'settingsTitle': "Settings"
    },
    'fr': {
      'title': 'Mon application',
      'language': 'Langue',
      'settingsTitle': "Param",
    },
    'hi': {
      'title': 'मेरा एप्प',
      'language': 'भाषा',
      'settingsTitle': "dfdfd",
    },
  };

  String? get title {
    return _localizedValues[locale.languageCode]!['title'];
  }

  String? get language {
    return _localizedValues[locale.languageCode]!['language'];
  }

  String? get settingsTitle {
    return _localizedValues[locale.languageCode]!['settingsTitle'];
  }
}
