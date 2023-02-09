import 'package:flutter/material.dart';

class CustomErrorMessage extends StatelessWidget {
  const CustomErrorMessage({Key? key, required this.errorMsg})
      : super(key: key);

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        errorMsg,
        style: TextStyle(color: Colors.red[400], fontSize: 14),
      ),
    );
  }
}
