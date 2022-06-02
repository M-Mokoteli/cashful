import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/payment_info_model.dart';

abstract class IPaymentService {
  Future<DocumentSnapshot> getPaymentInfo(String uid);

  Future<bool> addPaymentInfo(PaymentInfo paymentInfo, String uid);
}

class PaymentService extends IPaymentService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _paymentInfoRef;

  PaymentService() {
    _paymentInfoRef = _firestore.collection("payment_infos");
  }

  @override
  Future<DocumentSnapshot<Object?>> getPaymentInfo(String uid) async {
    return await _paymentInfoRef.doc(uid).get();
  }

  Future<bool> addPaymentInfo(PaymentInfo paymentInfo, String uid) async {
    Map<String, dynamic> postData = paymentInfo.toMap();
    postData["reference_number"] = uid.substring(0, 8);
    try {
      await _paymentInfoRef.doc(uid).set(postData);
      return true;
    } catch (e) {
      return false;
    }
  }
}
