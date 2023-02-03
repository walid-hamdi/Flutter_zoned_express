import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;

  const ScaffoldWrapper({
    Key? key,
    required this.child,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: child),
    );
  }
}
