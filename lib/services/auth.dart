import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoned_express/utils/constants.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
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
    } catch (e) {
      return null;
    }
  }

  // sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // check if user is logged in
  Future<bool> isLoggedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  // get current user
  // Future<User> getCurrentUser() async {
  //   return _auth.currentUser!;
  // }
}
