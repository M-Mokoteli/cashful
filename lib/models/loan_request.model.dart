import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LoanRequest {
  late String loanType;
  late String loanDetail;
  late String loanAmount;
  LoanRequest({
    required this.loanType,
    required this.loanDetail,
    required this.loanAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'loanType': loanType,
      'loanDetail': loanDetail,
      'loanAmount': loanAmount,
    };
  }

  factory LoanRequest.fromMap(Map<String, dynamic> map) {
    return LoanRequest(
      loanType: map['loanType'] ?? '',
      loanDetail: map['loanDetail'] ?? '',
      loanAmount: map['loanAmount'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanRequest.fromJson(String source) =>
      LoanRequest.fromMap(json.decode(source));

  factory LoanRequest.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return LoanRequest.fromMap(data);
  }
}
