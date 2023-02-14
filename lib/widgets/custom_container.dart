import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: child,
    );
  }
}
