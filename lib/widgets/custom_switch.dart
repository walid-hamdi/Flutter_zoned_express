import "package:flutter/material.dart";

class CustomSwitch extends StatelessWidget {
  final bool value;
  final Function(bool val) onChanged;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Colors.lightBlue,
      value: value,
      onChanged: onChanged,
    );
  }
}
