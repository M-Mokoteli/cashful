import 'dart:io';

import 'package:flutter_application_1/configs/firebase_helper.dart';
import 'package:flutter_application_1/models/payment_info_model.dart';
import 'package:flutter_application_1/repositories/user_repo.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';

class VerificationViewModel extends BaseViewModel {
  UserRepository _userRepository;
  FirebaseHelper _firebaseHelper;
  VerificationViewModel(this._userRepository, this._firebaseHelper);

  Future<bool> uploadIdentification(File file) async {
    setState(ViewState.Busy);
    try {
      var result = await _userRepository.uploadIdentification(
          file, _firebaseHelper.getUserId()!);
      setState(ViewState.Idle);
      return result;
    } catch (e) {
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> uploadBankStatement(File file) async {
    setState(ViewState.Busy);
    try {
      var result = await _userRepository.uploadBankStatement(
          file, _firebaseHelper.getUserId()!);
      setState(ViewState.Idle);
      return result;
    } catch (e) {
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> uploadProofOfAddress(File file) async {
    setState(ViewState.Busy);
    try {
      var result = await _userRepository.uploadProofOfAddress(
          file, _firebaseHelper.getUserId()!);
      setState(ViewState.Idle);
      return result;
    } catch (e) {
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> addPaymentInfo(PaymentInfo paymentInfo) async {
    setState(ViewState.Busy);
    try {
      // var result = await _userRepository.addPaymentInfo(
      //     paymentInfo, _firebaseHelper.getUserId()!);
      setState(ViewState.Idle);
      return true;
    } catch (e) {
      setState(ViewState.Idle);
      return false;
    }
  }
}
