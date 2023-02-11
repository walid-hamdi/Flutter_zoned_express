import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import "../../../widgets/loading.dart";
import "../../utils/user/user_provider.dart";
import "./profile/profile_view.dart";
import "./sign_in/sign_in_view.dart";
import "../verified_email/verified_email_view.dart";

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
            if (user.emailVerified) return const VerifiedEmailView();

            return ProfileView();
          } else {
            return const SignInView();
          }
          // return user != null
          //     ? ProfileView()
          //     : user!.emailVerified
          //         ? const SignInView()
          //         : const VerifiedEmailView();
        }
        return const Loading();
      },
    );
  }
}


// add articles 
// add ability to add to bookmark