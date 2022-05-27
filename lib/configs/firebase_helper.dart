import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  static final _firebaseAuthInstance = FirebaseAuth.instance;
  // static String? getUserId() {
  //   return _firebaseAuthInstance.currentUser?.uid;
  // }

  String? getUserId() {
    return _firebaseAuthInstance.currentUser?.uid;
  }
}
