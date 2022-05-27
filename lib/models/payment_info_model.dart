import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/bank_detail_model.dart';
import 'package:flutter_application_1/models/mtn_detail.dart';

import '../configs/firebase_helper.dart';
import '../configs/locator.dart';

class PaymentInfo {
  late BankDetail? bankDetail;
  late MtnDetail? mtnDetail;
  String referenceNumber;

  PaymentInfo({
    this.bankDetail,
    this.mtnDetail,
    this.referenceNumber = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'bankDetail': bankDetail?.toMap(),
      'mtnDetail': mtnDetail?.toMap(),
      'reference_number': referenceNumber,
    };
  }

  factory PaymentInfo.fromMap(Map<String, dynamic> map) {
    return PaymentInfo(
      bankDetail: map['bankDetail'] != null
          ? BankDetail.fromMap(map['bankDetail'])
          : null,
      mtnDetail:
          map['mtnDetail'] != null ? MtnDetail.fromMap(map['mtnDetail']) : null,
      referenceNumber: map['reference_number'] ??
          (locator.get<FirebaseHelper>().getUserId() ?? "          ")
              .substring(0, 8),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentInfo.fromJson(String source) =>
      PaymentInfo.fromMap(json.decode(source));

  factory PaymentInfo.fromFirebase(DocumentSnapshot<Object?> snapshot) {
    if (snapshot.data() == null) {
      return PaymentInfo();
    }

    var data = snapshot.data() as Map<String, dynamic>;
    return PaymentInfo(
      bankDetail: data['bankDetail'] != null
          ? BankDetail.fromMap(data['bankDetail'])
          : null,
      mtnDetail: data['mtnDetail'] != null
          ? MtnDetail.fromMap(data['mtnDetail'])
          : null,
      referenceNumber: data['reference_number'] ??
          (locator.get<FirebaseHelper>().getUserId() ?? "          ")
              .substring(0, 8),
    );
  }
}
