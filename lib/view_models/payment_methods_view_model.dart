import 'package:flutter_application_1/configs/firebase_helper.dart';
import 'package:flutter_application_1/models/payment_info_model.dart';
import 'package:flutter_application_1/repositories/user_repo.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';

class PaymentMethodViewModel extends BaseViewModel {
  UserRepository _userRepository;
  FirebaseHelper _firebaseHelper;
  PaymentMethodViewModel(this._userRepository, this._firebaseHelper);
  Future<bool> updatePaymentInfo(PaymentInfo paymentInfo) async {
    try {
      setState(ViewState.Busy);
      if (paymentInfo.bankDetail == null && paymentInfo.mtnDetail == null) {
        return false;
      }
      var result = await _userRepository.addPaymentInfo(
          paymentInfo, _firebaseHelper.getUserId()!);
      // if (result) {
      //   var userVm = locator<UserViewModel>();
      //   if (paymentInfo.bankDetail != null) {
      //     userVm.user!.bankDetail = paymentInfo.bankDetail;
      //   } else if (paymentInfo.mtnDetail != null) {
      //     userVm.user!.mtnDetail = paymentInfo.mtnDetail;
      //   }
      // }
      setState(ViewState.Idle);
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
