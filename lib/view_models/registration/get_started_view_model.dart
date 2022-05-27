import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/repositories/user_repo.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';

class GetStartedViewModel extends BaseViewModel {
  final UserRepository _userRepository;
  GetStartedViewModel(this._userRepository);
  Future<bool> register(User user) async {
    // Add user to firestore database
    setState(ViewState.Busy);
    bool registrationStatus = await _userRepository.registerUser(user);
    setState(ViewState.Idle);
    return registrationStatus;
  }
}
