import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import "../../../views/auth/sign_in/sign_in_view.dart";
import "../../../widgets/loading.dart";
import "../../utils/user/user_provider.dart";
import "./profile/profile_view.dart";

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: waitForUser(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: Text('No network connection. Please try again later.'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          User? user = snapshot.data;
          debugPrint(user?.email);
          if (user != null) {
            // debugPrint("EMAIL VERIFIED :${user.emailVerified}");
            // user.reload();

            // if (!user.emailVerified) {
            //   // return EmailVerificationView();
            //   ErrorUtil.showErrorDialog(context,
            //       "Here will implement email verification to allow only user with valid email.");
            // }
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
