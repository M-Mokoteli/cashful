import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/background_info_model.dart';
import 'package:flutter_application_1/models/documents_model.dart';
import 'package:flutter_application_1/models/level_model.dart';
import 'package:flutter_application_1/models/payment_info_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/services/payment_service.dart';
import 'package:flutter_application_1/services/user_service.dart';

class UserRepository {
  UserService _userService;
  PaymentService _paymentService;

  UserRepository(this._userService, this._paymentService);

  Future<User?> getUser(String uid) async {
    DocumentSnapshot snapshot = await _userService.getUser(uid);
    if (snapshot.data() == null) {
      return null;
    }
    User user = User.fromFirebase(snapshot);
    // get user verification documents
    DocumentSnapshot verificationSnapshot =
        await _userService.getUserDocuments(uid);

    user.verificationDocuments = verificationSnapshot.data() != null
        ? VerificationDocuments.fromFirebase(verificationSnapshot)
        : null;
    // get paymnet infos
    DocumentSnapshot paymnetInfoSnapshot =
        await _paymentService.getPaymentInfo(uid);
    PaymentInfo paymentInfo = PaymentInfo.fromFirebase(paymnetInfoSnapshot);
    user.bankDetail = paymentInfo.bankDetail;
    user.mtnDetail = paymentInfo.mtnDetail;
    user.referenceNumber = paymentInfo.referenceNumber;

    DocumentSnapshot bgInfoSnapshot =
        await _userService.getBackgroundInformation(uid);
    // print(bgInfoSnapshot.data());
    user.backgroundInformation = bgInfoSnapshot.data() != null
        ? BackgroundInformation.fromFirebase(bgInfoSnapshot)
        : null;

    QuerySnapshot levelSnapshot = await _userService.getLevels();
    List<Level> levels = levelSnapshot.docChanges.map((e) {
      var level = Level.fromFirebase(e.doc);
      return level;
    }).toList();

    print(user.levelId);

    /*user.levelId = user.levelId != null
        ? user.levelId!
        : levels.firstWhere((level) => level.name == 'level1').id;*/

    return user;
  }

  Future<bool> registerUser(User user) async {
    return await _userService.registerUser(user);
  }

  Future<bool> uploadIdentification(File file, String uid) async {
    return await _userService.uploadIdentification(file, uid);
  }

  Future<bool> uploadBankStatement(File file, String uid) async {
    return await _userService.uploadBankStatement(file, uid);
  }

  Future<bool> uploadProofOfAddress(File file, String uid) async {
    return await _userService.uploadProofOfAddress(file, uid);
  }

  Future<bool> addPaymentInfo(PaymentInfo paymentInfo, String uid) async {
    return await _paymentService.addPaymentInfo(paymentInfo, uid);
  }

  Future<bool> addBackgroundInfo(
      BackgroundInformation backgroundInformation, String uid) async {
    return await _userService.addBackgroundInformation(
        backgroundInformation, uid);
  }
}
