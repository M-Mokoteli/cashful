import 'package:flutter_application_1/configs/firebase_helper.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/repositories/user_repo.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  UserRepository _userRepository;
  FirebaseHelper _firebaseHelper;
  SplashViewModel(this._userRepository,this._firebaseHelper);
  User? _user;

  get user => _user;

  Future<User?> getUser() async {
    errorMessage = null;
    setState(ViewState.Busy);
    // get user from user repository
    try {
      _user = await this._userRepository.getUser(_firebaseHelper.getUserId()!);
      setState(ViewState.Idle);
      return user;
    } catch (error, stk) {
      print(error);
      print(stk);
      errorMessage = "error";
      setState(ViewState.Idle);
      return null;
    }
  }
}
