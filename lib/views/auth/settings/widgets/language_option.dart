import 'package:flutter/material.dart';

class LanguageOption extends StatelessWidget {
  final String selectedLanguage;
  final Function(String? val) onChangeLanguage;

  const LanguageOption({
    Key? key,
    required this.selectedLanguage,
    required this.onChangeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: DropdownButton(
        value: selectedLanguage,
        items: const [
          DropdownMenuItem(
            value: "English",
            child: Text("English"),
          ),
          DropdownMenuItem(
            value: "Français",
            child: Text("Français"),
          ),
          DropdownMenuItem(
            value: "Hindi",
            child: Text("Hindi"),
          ),
        ],
        onChanged: onChangeLanguage,
      ),
    );
  }
}
