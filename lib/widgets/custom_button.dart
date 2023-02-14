import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.backgroundColor})
      : super(key: key);

  final Function() onPressed;
  final String label;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size.fromHeight(40), // NEW
      ),
      onPressed: onPressed,
      child: Text(
        label,
      ),
    );
  }
}
