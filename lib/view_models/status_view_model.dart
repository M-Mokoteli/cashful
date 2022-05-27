import 'package:flutter_application_1/configs/firebase_helper.dart';
import 'package:flutter_application_1/models/loan_request_model.dart';
import 'package:flutter_application_1/repositories/loan_request_repo.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';

class StatusViewModel extends BaseViewModel {
  LoanRequestRepository _loanRequestRepository;
  LoanRequest? loanRequest;
  FirebaseHelper _firebaseHelper;
  StatusViewModel(this._loanRequestRepository, this._firebaseHelper);

  Future<bool> getUserLoan() async {
    try {
      setState(ViewState.Busy);
      var result = await _loanRequestRepository
          .getUserLoan(_firebaseHelper.getUserId()!);
      loanRequest = result;
      setState(ViewState.Idle);

      return true;
    } catch (e) {
      return false;
    }
  }
}
