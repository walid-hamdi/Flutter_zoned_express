import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../widgets/custom_bottom_bar.dart';
import '../services/auth.dart';
import '../utils/languages/local_notifier.dart';
import "../utils/languages/my_localizations_delegate.dart";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        initialData: null,
        value: AuthService().user,
        child: ChangeNotifierProvider(
          create: (context) => LocaleNotifier(),
          child: MaterialApp(
            // supportedLocales: supportedLocales,
            supportedLocales:
                WidgetsFlutterBinding.ensureInitialized().window.locales,
            localizationsDelegates: const [
              MyLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            title: 'Zoned Express',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const CustomBottomBar(),
          ),
        ));
  }
}
