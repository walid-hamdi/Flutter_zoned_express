import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoned_express/services/database.dart';
import 'package:zoned_express/utils/constants.dart';

import '../../../widgets/cached_image.dart';
import '../../../widgets/custom_error_msg.dart';
import '../../../widgets/custom_label.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/scaffold_wrapper.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';
import "../../../services/auth.dart";
import 'widgets/language_option.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  late String _photo;
  late String _username;
  // late String _email;
  late String _phone;
  // late String _password;
  late String _selectedLanguage;

  var _error = "";
  bool _loading = false;

  // User's current theme preference
  late ThemeData _currentTheme;

  // Function to update the user's theme preference
  void _updateTheme(ThemeData theme) {
    setState(() {
      _currentTheme = theme;
    });
  }

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

  // String? _passwordValidator(String? val) {
  //   if (val!.isEmpty) {
  //     return "Enter password";
  //   } else if (val.length < 6) {
  //     return "Password should be at least 6 characters long.";
  //   } else {
  //     return null;
  //   }
  // }

  _onChangePhoto(String? val) {
    setState(() {
      _photo = val!;
    });
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

  _onChangeLanguage(value) {
    setState(() {
      _selectedLanguage = value;
    });
    // change the language
  }

  // _onChangeEmail(String? val) {
  //   setState(() {
  //     _email = val!;
  //   });
  // }

  // _onChangePassword(String? val) {
  //   setState(() {
  //     _password = val!;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return _loading
        ? const Loading()
        : ScaffoldWrapper(
            appBar: AppBar(
              title: const Text('Settings'),
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
                            Container(
                              alignment: Alignment.center,
                              child: CachedNetworkImageWidget(
                                imageUrl: data["photo"] ??
                                    defaultProfilePlaceholderPhoto,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 40,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(
                                  height: 90,
                                  child: Icon(Icons.error),
                                ),
                              ),
                            ),
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
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // CustomInputField(
                            //   hintText: "Email",
                            //   icon: Icons.email,
                            //   onChange: _onChangeEmail,
                            //   validator: _emailValidator,
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            // CustomInputField(
                            //   obscureText: true,
                            //   hintText: "Password",
                            //   icon: Icons.lock,
                            //   onChange: _onChangePassword,
                            //   validator: _passwordValidator,
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            CustomBottom(
                              onPressed: updateOnPressed,
                              label: "Update",
                            ),
                            // const SizedBox(
                            //   height: 20,
                            // ),

                            CustomErrorMessage(errorMsg: _error),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                LanguageOption(
                                  selectedLanguage: "English",
                                  onChangeLanguage: _onChangeLanguage,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Label(
                                  label: "Dark/Light",
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
          );
  }
}
