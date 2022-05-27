import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/loan_request_model.dart';
import 'package:flutter_application_1/services/loan_request_service.dart';

class LoanRequestRepository {
  LoanRequestService _loanRequestService;
  LoanRequestRepository(this._loanRequestService);

  Future<bool> createLoanRequest(LoanRequest loanRequest) async {
    return await _loanRequestService.createLoanRequest(loanRequest);
  }

  Future<LoanRequest?> getUserLoan(String uid) async {
    QuerySnapshot loanSnapshot = await _loanRequestService.getUserLoan(uid);
    if (loanSnapshot.size == 0) {
      return null;
    } else {
      return LoanRequest.fromFirebase(loanSnapshot.docs[0]);
    }
  }

  Future<List<LoanRequest>> getUserLoans(String? userId) async {
    QuerySnapshot loanSnapshot =
        await _loanRequestService.getUserLoans(userId!);
    List<LoanRequest> loanRequests = loanSnapshot.docs.map<LoanRequest>((e){
      return LoanRequest.fromFirebase(e);
    }).toList();

    return loanRequests;
  }
}
