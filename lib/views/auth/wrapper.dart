import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:zoned_express/views/auth/sign_in/sign_in_view.dart";

import "../../../widgets/loading.dart";
import "../../utils/user/user_provider.dart";
import "./profile/profile_view.dart";
import 'email_verification/email_verification_view.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: waitForUser(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          User? user = snapshot.data;
          if (user != null) {
            if (!user.emailVerified) {
              return EmailVerificationView();
            }
            return ProfileView();
          } else {
            return const SignInView();
          }
        }
        return const Loading();
      },
    );
  }
}
