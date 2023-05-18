import 'package:flutter/material.dart';

class LanguageOption extends StatelessWidget {
  final Locale selectedLanguage;
  final Function(Locale? val) onChangeLanguage;

  const LanguageOption({
    Key? key,
    required this.selectedLanguage,
    required this.onChangeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: DropdownButton<Locale>(
          value: selectedLanguage,
          items: WidgetsFlutterBinding.ensureInitialized()
              // ignore: deprecated_member_use
              .window
              .locales
              .map((locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: Text(
                locale.countryCode.toString(),
              ),
            );
          }).toList(),
          onChanged: onChangeLanguage,
        ),
      ),
    );
  }
}
