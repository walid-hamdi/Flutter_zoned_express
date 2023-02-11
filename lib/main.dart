import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './widgets/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// handle back appbar leading icon to back to previous tab
// make the bookmark list vertical
// add bookmark if the user click to bookmark icon
// store the state of click state to each newsletter card
// delete if the user click to a tab that is already added to bookmark
// delete all bookmarks if click to action delete icon on appbar and show warning dialog first
// handle verification view after sign up and not verified
// update photo & username(username should be unique) & phone (and later email & password)
// forget password view
// handle theme of the app (light and dark)
// handle languages of the app (selected device languages)
// apply all exception handlers
// test the app on various devices
// apply widget and unit test 