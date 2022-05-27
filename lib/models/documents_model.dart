import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class VerificationDocuments {
  late String? id;
  late Map<String, dynamic>? bankStatement;
  late Map<String, dynamic>? idCard;
  late Map<String, dynamic>? proofOfAddress;
  VerificationDocuments({
    this.id,
    this.bankStatement,
    this.idCard,
    this.proofOfAddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bankStatement': bankStatement,
      'idCard': idCard,
      'proofOfAddress': proofOfAddress,
    };
  }

  factory VerificationDocuments.fromMap(Map<String, dynamic> map) {
    return VerificationDocuments(
      id: map['id'],
      idCard: map['idCard'] != null
          ? Map<String, dynamic>.from(map['idCard'])
          : null,
      bankStatement: map['bankStatement'] != null
          ? Map<String, dynamic>.from(map['bankStatement'])
          : null,
      proofOfAddress: map['proofOfAddress'] != null
          ? Map<String, dynamic>.from(map['proofOfAddress'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationDocuments.fromJson(String source) =>
      VerificationDocuments.fromMap(json.decode(source));

  factory VerificationDocuments.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return VerificationDocuments.fromMap(data);
  }
}
