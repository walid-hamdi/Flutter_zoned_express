import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/database.dart';
import '../../../utils/languages/local_notifier.dart';
import '../../../utils/languages/my_app_localizations.dart';
import '../../../widgets/custom_avatar_photo.dart';
import '../../../widgets/error_msg.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/scaffold_wrapper.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';
import "../../../widgets/custom_switch.dart";
// import "../../../services/auth.dart";
import 'widgets/language_option.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _formKey = GlobalKey<FormState>();
  late String _photo;
  late String _username;
  late String _phone;
  late Locale _selectedLocale;
  ThemeMode _themeMode = ThemeMode.light;

  var _error = "";
  bool _loading = false;

  updateOnPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      // do authenticate
      var result = await DatabaseService().updateUserInfo(
        username: _username,
        phone: _phone,
        photo: _photo,
      );
      if (result == null) {
        setState(
          () {
            _error = "Error occurred.";
            _loading = false;
          },
        );
      }
    }
  }

  // String? _emailValidator(String? val) => val!.isEmpty ? "Enter Email" : null;
  String? _usernameValidator(String? val) =>
      val!.isEmpty ? "Enter username" : null;

  String? _phoneValidator(String? val) => val!.isEmpty ? "Enter phone" : null;

  @override
  void initState() {
    super.initState();
    _selectedLocale = const Locale('en', 'US');
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  _onChangedTheme(value) {
    _toggleTheme();
  }

  _onChangeUsername(String? val) {
    setState(() {
      _username = val!;
    });
  }

  _onChangePhone(String? val) {
    setState(() {
      _phone = val!;
    });
  }

  void _selectLanguage(Locale? locale) {
    setState(() {
      _selectedLocale = locale!;
    });
    Provider.of<LocaleNotifier>(context, listen: false).setLocale(locale!);
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return Theme(
      data: Theme.of(context).copyWith(
        brightness:
            _themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
      ),
      child: _loading
          ? const Loading()
          : ScaffoldWrapper(
              appBar: AppBar(
                title: Text(MyAppLocalizations.of(context)?.settingsTitle ??
                    "Settings"),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: DatabaseService(uid: user?.uid).userData,
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) return const Text("Error");

                      if (snapshot.hasData) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CustomAvatarPhoto(data: data),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomInputField(
                                initialValue: data["username"],
                                hintText: "Username",
                                icon: Icons.person,
                                onChange: _onChangeUsername,
                                validator: _usernameValidator,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomInputField(
                                initialValue: data["phone"],
                                hintText: "Phone",
                                icon: Icons.phone,
                                onChange: _onChangePhone,
                                validator: _phoneValidator,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomBottom(
                                onPressed: updateOnPressed,
                                label: "Update",
                              ),
                              CustomErrorMessage(errorMsg: _error),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  LanguageOption(
                                    selectedLanguage: _selectedLocale,
                                    onChangeLanguage: _selectLanguage,
                                  ),
                                  CustomSwitch(
                                    value: _themeMode == ThemeMode.light,
                                    onChanged: _onChangedTheme,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Loading();
                      }
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
