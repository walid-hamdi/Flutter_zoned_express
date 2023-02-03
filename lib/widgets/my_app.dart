import 'package:flutter/material.dart';
import 'package:zoned_express/widgets/custom_bottom_bar.dart';
import '../themes/custom_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoned Express',
      theme: customTheme,
      home: const CustomBottomBar(),
    );
  }
}
