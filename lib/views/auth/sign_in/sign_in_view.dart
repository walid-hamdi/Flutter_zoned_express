import "package:flutter/material.dart";

import "../../../services/auth.dart";
import "../../../utils/theme/theme_provider.dart";
import '../../../widgets/custom_container.dart';
import "../../../widgets/error_msg.dart";
import "../../../widgets/custom_input_field.dart";
import '../../../widgets/loading.dart';
import "../../../widgets/scaffold_wrapper.dart";
import "../../../widgets/custom_button.dart";
import "../sign_up/sign_up_view.dart";

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

  var _error = "";
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

  _signInOnPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      debugPrint("EMAIL: $_email");
      debugPrint("PASSWORD: $_password");

      // do authenticate
      var result = await _auth.signInWithEmailAndPassword(_email, _password);
      debugPrint(result);
      if (result == null) {
        setState(
          () {
            _error = "Invalid Credentials.";
            _loading = false;
          },
        );
      }
    }
  }

  _goToCreateAccountOnPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpView(),
      ),
    );
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
                        CustomErrorMessage(errorMsg: _error),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
