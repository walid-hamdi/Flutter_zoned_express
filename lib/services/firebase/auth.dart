import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../utils/constants.dart';
import '../../utils/error_util.dart';
import 'database.dart';
import 'firebase_exception_handler.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(
      context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      String errorMessage = FirebaseExceptionHandler.handleException(e);
      debugPrint(errorMessage);
      ErrorUtil.showErrorDialog(context, errorMessage);
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword({
    required context,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // register user info
      final DatabaseService databaseService =
          DatabaseService(uid: result.user!.uid);
      databaseService.updateUserInfo(
        email: email,
        username: username,
        phone: defaultPhoneProfile,
        photo: defaultProfilePlaceholderPhoto,
      );

      result.user!.sendEmailVerification();
      return result.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseExceptionHandler.handleException(e);
      debugPrint(errorMessage);
      ErrorUtil.showErrorDialog(context, errorMessage);
    }
  }

  // sign out
  Future<void> signOut(context) async {
    try {
      return await _auth.signOut();
    } catch (e) {
      String errorMessage = FirebaseExceptionHandler.handleException(e);
      ErrorUtil.showErrorDialog(context, errorMessage);
    }
  }

  // check if user is logged in
  Future<bool> isLoggedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }
}
