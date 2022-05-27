import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/view_models/splash_view_model.dart';
import 'package:flutter_application_1/models/user_model.dart' as um;

enum AuthState { Idle, CodeSent, Failed, Success, Busy }

class AuthViewModel extends ChangeNotifier {
  late FirebaseAuth _auth;
  AuthState authState = AuthState.Idle;
  String? _verificationId;
  um.User? user;

  AuthViewModel() {
    _auth = FirebaseAuth.instance;
  }

  void sendOTP(String phoneNumber) async {
    authState = AuthState.Busy;
    notifyListeners();
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    // automatically authenticate only for android
  }

  void _verificationFailed(FirebaseAuthException e) async {
    if (e.code == 'invalid-phone-number') {
      authState = AuthState.Failed;
      notifyListeners();
    }
    authState = AuthState.Failed;
    notifyListeners();
  }

  void _codeSent(String verificationId, int? resendToken) async {
    _verificationId = verificationId;
    authState = AuthState.CodeSent;
    notifyListeners();
  }

  void _codeAutoRetrievalTimeout(String verificationId) async {}

  // ignore: non_constant_identifier_names
  void verifyOTP(String OTP) async {
    try {
      assert(_verificationId != null);
      print("Verifiying OTP");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: OTP);
      authState = AuthState.Busy;
      notifyListeners();
      UserCredential _userCredential =
          await _auth.signInWithCredential(credential);
      _userCredential.user!.uid;
      user = await locator<SplashViewModel>().getUser();
      authState = AuthState.Success;
      notifyListeners();
    } catch (e) {
      authState = AuthState.Failed;
      notifyListeners();
    }
  }
}
