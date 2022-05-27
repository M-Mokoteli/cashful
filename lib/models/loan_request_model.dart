import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LoanRequest {
  late String? id;
  late String? userId;
  late String loanType;
  late String loanAmount;
  late String loanDetail;
  late String totalRepayable;
  late String? loanStatus;
  late String paymentTime;
  late String? loanDate;
  LoanRequest(
      {this.id,
      this.userId,
      required this.loanType,
      required this.loanAmount,
      required this.loanDetail,
      required this.totalRepayable,
      this.loanStatus = "pending",
      required this.paymentTime,
      this.loanDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'loanType': loanType,
      'loanAmount': loanAmount,
      'loanDetail': loanDetail,
      'totalRepayable': totalRepayable,
      'loanStatus': loanStatus,
      'paymentTime': paymentTime,
      'loanDate': loanDate,
    };
  }

  factory LoanRequest.fromMap(Map<String, dynamic> map) {
    return LoanRequest(
      id: map['id'],
      userId: map['userId'],
      loanType: map['loanType'] ?? '',
      loanAmount: map['loanAmount'] ?? '',
      loanDetail: map['loanDetail'] ?? '',
      totalRepayable: map['totalRepayable'] ?? '',
      loanStatus: map['loanStatus'],
      paymentTime: map['paymentTime'] ?? '',
      loanDate: map['loanDate'],
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

  factory LoanRequest.mock() {
    return LoanRequest(
      id: "",
      loanDate: "2022-03-19 13:24:41.748406",
      loanAmount: "100.00",
      loanDetail: "frt ",
      loanStatus: "pending",
      loanType: "Personal",
      paymentTime: "7",
      totalRepayable: "112.00",
      userId: "",
    );
  }
}
