import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './widgets/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// 0- show all bookmarks correctly
// 1- save the changes of the bookmark in shared preferences
// 2- solve the category filter issue
// 3- add the functionality to show the article detail
// 4- search for bookmark functionality
// 5- add delete all bookmarks ability
// 6- add photo and update user info in setting view
// 7- solve the issue of updating all user info
// 8- add the functionality to change language of the app
// 9- add the ability to change the theme of the app
// 10- add notification in home view when there is anything new
// 11- in bookmark and profile make the back button in the app bar work to back to previous view in tab bottom   
// 12- delete bookmark when click to it and it's already marked
// 13- make sure that the app work in all devices  