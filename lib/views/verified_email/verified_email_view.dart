import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/user/user_provider.dart';
import '../../widgets/custom_button.dart';

class VerifiedEmailView extends StatelessWidget {
  const VerifiedEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = getUser(context);
    return CustomButton(
      label: "Verify Now",
      onPressed: () {
        _checkEmailVerification(context, user!);
      },
    );
  }

  void _checkEmailVerification(BuildContext context, User user) {
    bool isEmailVerified = user.emailVerified;
    if (!isEmailVerified) {
      _showVerifyEmailDialog(context, user);
    }
  }

  void _showVerifyEmailDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Verify your email address"),
          content:
              const Text("Please check your email and verify your account."),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Resend verification email"),
              onPressed: () {
                user.sendEmailVerification();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
