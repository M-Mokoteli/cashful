import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }
}
