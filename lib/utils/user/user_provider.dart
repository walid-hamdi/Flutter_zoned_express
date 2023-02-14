import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

User? getUser(BuildContext context) {
  return Provider.of<User?>(context);
}

Future<User> waitForUser(BuildContext context) async {
  return Provider.of<User>(context);
}
