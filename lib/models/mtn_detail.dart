import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MtnDetail {
  late String fullName;
  late String accountNumber;
  MtnDetail({
    required this.fullName,
    required this.accountNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'accountNumber': accountNumber,
    };
  }

  factory MtnDetail.fromMap(Map<String, dynamic> map) {
    return MtnDetail(
      fullName: map['fullName'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MtnDetail.fromJson(String source) =>
      MtnDetail.fromMap(json.decode(source));

  factory MtnDetail.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return MtnDetail.fromMap(data);
  }
}
