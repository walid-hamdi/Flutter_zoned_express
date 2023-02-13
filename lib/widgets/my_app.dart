import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zoned_express/widgets/custom_bottom_bar.dart';

import '../../themes/theme_notifier.dart';
import '../services/firebase/auth.dart';
import '../utils/languages/local_notifier.dart';
import "../utils/languages/my_localizations_delegate.dart";
import "../utils/constants.dart";
import '../views/auth/sign_in/sign_in_view.dart';
import '../views/auth/sign_up/sign_up_view.dart';
import '../views/auth/email_verification/email_verification_view.dart';
import '../views/auth/profile/profile_view.dart';
import '../views/auth/settings/settings_view.dart';
import '../views/splash_screen/splash_screen_view.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: _auth.user,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<LocaleNotifier>(
            create: (_) => LocaleNotifier(),
          ),
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => ThemeNotifier(),
          ),
        ],
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
          // theme: ThemeData.light(),
          // darkTheme: ThemeData.dark(),
          // themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashScreen,
          routes: {
            Routes.splashScreen: (context) => const SplashScreen(),
            Routes.home: (context) => const CustomBottomBar(),
            Routes.login: (context) => const SignInView(),
            Routes.register: (context) => const SignUpView(),
            Routes.profile: (context) => ProfileView(),
            Routes.emailVerification: (context) => EmailVerificationView(),
            Routes.settings: (context) => const SettingsView(),
          },
        ),
      ),
    );
  }
}
