import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password, String username, String phone) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
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
  Future<User> getCurrentUser() async {
    return _auth.currentUser!;
  }
}
