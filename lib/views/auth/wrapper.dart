import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import "../../../widgets/loading.dart";
import "./profile/profile_view.dart";
import "./sign_in/sign_in_view.dart";

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _waitForUser(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final user = snapshot.data;
          return user != null ? ProfileView() : const SignInView();
        }
        return const Loading();
      },
    );
  }

  Future<User?> _waitForUser(BuildContext context) async {
    return Provider.of<User?>(context);
  }
}


// add articles 
// add ability to add to bookmark