import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_application_1/models/background_info_model.dart';
import 'package:flutter_application_1/models/bank_detail_model.dart';
import 'package:flutter_application_1/models/documents_model.dart';
import 'package:flutter_application_1/models/mtn_detail.dart';

import '../configs/firebase_helper.dart';
import '../configs/locator.dart';

class User {
  late String firstName;
  late String lastName;
  late String id;
  late String address;
  late String mobileNumber;
  late String dob;
  late String fcmToken;
  late VerificationDocuments? verificationDocuments;
  late BankDetail? bankDetail;
  late MtnDetail? mtnDetail;
  String referenceNumber;
  late BackgroundInformation? backgroundInformation;
  late String levelId;
  bool isFirstTimeBorrower;

  User({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.address,
    required this.mobileNumber,
    required this.dob,
    required this.fcmToken,
    this.verificationDocuments,
    this.bankDetail,
    this.mtnDetail,
    this.backgroundInformation,
    this.levelId = "DNAI5I84fjoBYrWeJCP7", //By default to level 1
    this.isFirstTimeBorrower = true,
    this.referenceNumber = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
      'address': address,
      'mobileNumber': mobileNumber,
      'dob': dob,
      'fcmToken': fcmToken,
      'verificationDocuments': verificationDocuments?.toMap(),
      'bankDetail': bankDetail?.toMap(),
      'mtnDetail': mtnDetail?.toMap(),
      'reference_number': referenceNumber,
      'backgroundInformation': backgroundInformation?.toMap(),
      'levelId': levelId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      id: map['id'] ?? '',
      address: map['address'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      dob: map['dob'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      verificationDocuments: map['verificationDocuments'] != null
          ? VerificationDocuments.fromMap(map['verificationDocuments'])
          : null,
      bankDetail: map['bankDetail'] != null
          ? BankDetail.fromMap(map['bankDetail'])
          : null,
      mtnDetail:
          map['mtnDetail'] != null ? MtnDetail.fromMap(map['mtnDetail']) : null,

      referenceNumber: map['reference_number'] ??
          (locator.get<FirebaseHelper>().getUserId() ?? "          ")
              .substring(0, 8),
      backgroundInformation: map['backgroundInformation'] != null
          ? BackgroundInformation.fromMap(map['backgroundInformation'])
          : null,
      levelId: map['levelId'] ?? "DNAI5I84fjoBYrWeJCP7", //By default to level 1
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return User.fromMap(data);
  }
}
