import 'package:flutter_application_1/configs/firebase_helper.dart';
import 'package:flutter_application_1/models/background_info_model.dart';
import 'package:flutter_application_1/repositories/user_repo.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';

class ApplyViewModel extends BaseViewModel {
  UserRepository _userRepository;
  FirebaseHelper _firebaseHelper;
  ApplyViewModel(this._userRepository, this._firebaseHelper);

  BackgroundInformation backgroundInformation = BackgroundInformation();

  Future<bool> addBackgroundInfo() async {
    try {
      bool result = await _userRepository.addBackgroundInfo(
          backgroundInformation, _firebaseHelper.getUserId()!);
      return result;
    } catch (e, stc) {
      // print(e);
      print(stc);
      return false;
    }
  }
}
