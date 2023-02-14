import "package:flutter/material.dart";

import '../../../services/firebase/auth.dart';
import '../../../utils/constants.dart';
import '../../../utils/theme/theme_provider.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/scaffold_wrapper.dart';
import '../../../widgets/custom_button.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  var _email = "";
  var _password = "";
  bool _loading = false;

  String? _emailValidator(String? val) => val!.isEmpty ? "Enter Email" : null;
  String? _passwordValidator(String? val) {
    if (val!.isEmpty) {
      return "Enter password";
    } else if (val.length < 6) {
      return "Password should be at least 6 characters long.";
    } else {
      return null;
    }
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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getTheme(context),
      child: _loading
          ? const Loading()
          : ScaffoldWrapper(
              appBar: AppBar(
                title: const Text("Sign In"),
              ),
              child: CustomContainer(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                          onPressed: _signInOnPressed,
                          label: "Login",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomButton(
                          backgroundColor: Colors.blue[500],
                          onPressed: () {
                            _goToCreateAccountOnPressed(context);
                          },
                          label: "Create new account",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  _signInOnPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      // do authenticate
      await _auth
          .signInWithEmailAndPassword(
        context,
        _email,
        _password,
      )
          .whenComplete(() {
        setState(() {
          _loading = false;
        });
      });
    }
  }

  _goToCreateAccountOnPressed(BuildContext context) {
    Navigator.pushNamed(context, Routes.register);
  }
}
