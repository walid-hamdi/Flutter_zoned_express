import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "./my_app_localizations.dart";
import 'supported_local.dart';

class MyLocalizationsDelegate
    extends LocalizationsDelegate<MyAppLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.map((l) => l.languageCode).contains(locale.languageCode);

  @override
  Future<MyAppLocalizations> load(Locale locale) {
    return SynchronousFuture<MyAppLocalizations>(MyAppLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
