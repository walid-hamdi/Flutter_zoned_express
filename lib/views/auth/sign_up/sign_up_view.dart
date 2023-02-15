import "package:flutter/material.dart";

import "../../../services/firebase/auth.dart";
import "../../../utils/constants.dart";
import "../../../utils/theme/theme_provider.dart";
import "../../../widgets/custom_button.dart";
import '../../../widgets/custom_container.dart';
import "../../../widgets/custom_input_field.dart";
import '../../../widgets/loading.dart';
import "../../../widgets/scaffold_wrapper.dart";

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  var _email = "";
  var _password = "";
  var _username = "";
  bool _loading = false;

  _onChangeUsername(String? val) {
    setState(() {
      _username = val!;
    });
  }

  _onChangeEmail(String? val) {
    setState(() {
      _email = val!;
    });
  }

  _onChangePassword(String? val) {
    setState(() {
      _password = val!;
    });
  }

  String? _usernameValidator(String? val) =>
      val!.isEmpty ? "Enter username" : null;
  String? _emailValidator(String? val) {
    if (val!.isEmpty) {
      return "Enter email";
    }

    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!regex.hasMatch(val)) {
      return "Please provide a valid email.";
    }

    return null;
  }

  String? _passwordValidator(String? val) {
    if (val!.isEmpty) {
      return "Enter password";
    } else if (val.length < 6) {
      return "Password should be at least 6 characters long.";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getTheme(context),
      child: _loading
          ? const Loading()
          : ScaffoldWrapper(
              appBar: AppBar(
                title: const Text("Sign Up"),
              ),
              child: CustomContainer(
                // padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomInputField(
                          hintText: "Username",
                          icon: Icons.person,
                          onChange: _onChangeUsername,
                          validator: _usernameValidator,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomInputField(
                          hintText: "Email",
                          icon: Icons.email,
                          onChange: _onChangeEmail,
                          validator: _emailValidator,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomInputField(
                          obscureText: true,
                          hintText: "Password",
                          icon: Icons.lock,
                          onChange: _onChangePassword,
                          validator: _passwordValidator,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onPressed: _signUpOnPressed,
                          label: "Create",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  _signUpOnPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      await _auth
          .registerWithEmailAndPassword(
              context: context,
              username: _username,
              email: _email,
              password: _password)
          .whenComplete(() {
        setState(() {
          _loading = false;
        });
        Navigator.pushReplacementNamed(context, Routes.profile);
      });
    }
  }
}
