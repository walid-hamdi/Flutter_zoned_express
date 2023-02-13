import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';
import '../../../utils/error_util.dart';
import '../../../services/firebase/auth.dart';
import '../../../utils/theme/theme_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/scaffold_wrapper.dart';

class EmailVerificationView extends StatelessWidget {
  EmailVerificationView({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.user,
      builder: (context, snapshot) {
        User? user = snapshot.data;
        if (snapshot.hasData && snapshot.data!.emailVerified) {
          Navigator.pushReplacementNamed(context, Routes.profile);
        }

        return Theme(
          data: getTheme(context),
          child: ScaffoldWrapper(
            appBar: AppBar(
              title: const Text("Email Verification"),
            ),
            child: CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Please verify your email address. (${user!.email})"),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    label: "Resend Verification Email",
                    onPressed: () {
                      // code to send email verification
                      user.sendEmailVerification();
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomButton(
                    label: "Open Mail",
                    onPressed: () async {
                      await launchUrl(Uri.parse("mailto:${user.email}"));
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomButton(
                    label: "Logout",
                    onPressed: () async {
                      await _auth.signOut(context);
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomButton(
                    backgroundColor: Colors.red[700],
                    label: "Delete Account",
                    onPressed: () async {
                      ErrorUtil.showDeleteCheckDialog(context, onCancel: () {
                        Navigator.of(context).pop();
                      }, onDelete: () async {
                        await user.delete();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
