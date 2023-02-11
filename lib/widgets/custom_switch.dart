import "package:flutter/material.dart";
import "package:zoned_express/utils/theme/theme_provider.dart";

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
      activeColor: getTheme(context).primaryColor,
      value: value,
      onChanged: onChanged,
    );
  }
}
