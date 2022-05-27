import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/background_info_model.dart';
import 'package:flutter_application_1/models/documents_model.dart';
import 'package:flutter_application_1/models/payment_info_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';

class UserViewModel extends BaseViewModel {
  FirebaseFirestore _firestore;

  UserViewModel(this._firestore);

  User? user;

  void setUser(User user) {
    this.user = user;

    _firestore
        .collection('loan_requests')
        .where('userId', isEqualTo: user.id)
        .get()
        .then((value) {
      if (value.size > 0) {
        this.user?.isFirstTimeBorrower = false;
      }
    });
    Stream<DocumentSnapshot> _bgInfoStream = _firestore
        .collection("background_informations")
        .doc(this.user!.id)
        .snapshots();
    Stream<DocumentSnapshot> _paymentInfoStream =
        _firestore.collection("payment_infos").doc(this.user!.id).snapshots();

    Stream<DocumentSnapshot> _userDocsStream =
        _firestore.collection("user_documents").doc(this.user!.id).snapshots();

    _bgInfoStream.listen((snapshot) {
      if (snapshot.data() != null) {
        print(snapshot.data());
        this.user!.backgroundInformation =
            BackgroundInformation.fromFirebase(snapshot);
      }
    });

    _paymentInfoStream.listen((snapshot) {
      if (snapshot.data() != null) {
        print(snapshot.data());
        var paymentInfo = PaymentInfo.fromFirebase(snapshot);
        this.user!.bankDetail = paymentInfo.bankDetail;
        this.user!.mtnDetail = paymentInfo.mtnDetail;
        this.user!.referenceNumber = paymentInfo.referenceNumber;
      }
    });

    _userDocsStream.listen((snapshot) {
      if (snapshot.data() != null) {
        print(snapshot.data());
        var userDocs = VerificationDocuments.fromFirebase(snapshot);
        this.user!.verificationDocuments = userDocs;
        notifyListeners();
      }
    });
  }
}
