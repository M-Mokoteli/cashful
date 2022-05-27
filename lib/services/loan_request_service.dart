import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/loan_request_model.dart';

abstract class ILoanRequestService {
  Future<bool> createLoanRequest(LoanRequest loanRequest);
  Future<QuerySnapshot> getUserLoan(String uid);
}

class LoanRequestService extends ILoanRequestService {
  late CollectionReference _loanRequestCollRef;
  LoanRequestService() {
    _loanRequestCollRef =
        FirebaseFirestore.instance.collection("loan_requests");
  }

  @override
  Future<bool> createLoanRequest(LoanRequest loanRequest) async {
    await _loanRequestCollRef.add(loanRequest.toMap());
    return true;
  }

  Future<QuerySnapshot> getUserLoan(String uid) async {
    QuerySnapshot requestSnapshot = await _loanRequestCollRef
        .where('userId', isEqualTo: uid)
        .where('loanStatus', isEqualTo: 'approved')
        .limit(1)
        .get();
    return requestSnapshot;
  }

  Future<QuerySnapshot> getUserLoans(String s) async{
    QuerySnapshot requestSnapshot = await _loanRequestCollRef
        .where('userId', isEqualTo: s)
        .where('loanStatus')
        .get();
    return requestSnapshot;
  }
}
