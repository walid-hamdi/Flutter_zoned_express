import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_bottom_bar.dart';
import '../services/auth.dart';
import '../themes/custom_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        initialData: null,
        value: AuthService().user,
        child: MaterialApp(
          title: 'Zoned Express',
          theme: customTheme,
          debugShowCheckedModeBanner: false,
          home: const CustomBottomBar(),
        ));
  }
}
