import 'package:flutter/material.dart';
import '../views/home/home_view.dart';
import '../themes/custom_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoned Express',
      theme: customTheme,
      home: const HomeView(),
    );
  }
}
