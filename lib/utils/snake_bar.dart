import 'package:flutter/material.dart';

showSnakeBar({
  required BuildContext context,
  required String content,
  required String label,
  required Function() onPressed,
}) {
  final snackBar = SnackBar(
    content: Text(content),
    action: SnackBarAction(
      label: label,
      onPressed: onPressed,
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
