import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_application_1/models/background_info_model.dart';
import 'package:flutter_application_1/models/user_model.dart';

abstract class IUserService {
  Future<DocumentSnapshot<Object?>> getUser(String uid);
  Future<bool> registerUser(User user);
  Future<DocumentSnapshot<Object?>> getUserDocuments(String uid);
  Future<bool> uploadIdentification(File file, String uid);
  Future<bool> uploadBankStatement(File file, String uid);
  Future<bool> uploadProofOfAddress(File file, String uid);
  Future<bool> addBackgroundInformation(
      BackgroundInformation backgroundInformation, String uid);
  Future<DocumentSnapshot<Object?>> getBackgroundInformation(String uid);
}

class UserService implements IUserService {
  FirebaseFirestore _firestore;
  late CollectionReference _usersRef;
  late CollectionReference _userDocsRef;
  late CollectionReference _userBgInfoRef;
  late CollectionReference _levelInfoRef;
  UserService(this._firestore) {
    _usersRef = _firestore.collection("users_n");
    _userDocsRef = _firestore.collection("user_documents");
    _userBgInfoRef = _firestore.collection("background_informations");
    _levelInfoRef = _firestore.collection("levels");
  }

  @override
  Future<DocumentSnapshot<Object?>> getUser(String uid) async {
    DocumentSnapshot snapshot = await _usersRef.doc(uid).get();
    return snapshot;
  }

  @override
  Future<bool> registerUser(User user) async {
    try {
      await _usersRef
          .doc(user.id)
          .set(user.toMap())
          .timeout(Duration(seconds: 10));
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<DocumentSnapshot<Object?>> getUserDocuments(String uid) async {
    DocumentSnapshot snapshot = await _userDocsRef.doc(uid).get();
    return snapshot;
  }

  Future<bool> uploadIdentification(File file, String uid) async {
    String url = await uploadFile(file, uid, "identification");
    // check if document exists first
    print("here");
    var snapshot = await _userDocsRef.doc(uid).get();
    if (snapshot.data() == null) {
      await _userDocsRef.doc(uid).set({
        "idCard": {
          "url": url,
          "status": "pending",
        }
      });
    } else {
      // add identification to user document
      await _userDocsRef.doc(uid).update({
        "idCard": {
          "url": url,
          "status": "pending",
        }
      });
    }

    return true;
  }

  uploadFile(file, uid, docname) async {
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref("uploads/${uid}_$docname." + file.path.split('.').last);
    firebase_storage.UploadTask task = reference.putFile(file);
    await task;
    String _myUrl = await reference.getDownloadURL();
    return _myUrl.toString();
  }

  @override
  Future<bool> uploadBankStatement(
    File file,
    String uid,
  ) async {
    String url = await uploadFile(file, uid, "bankstatement");
    // add identification to user document
    await _userDocsRef.doc(uid).update({
      "bankStatement": {
        "url": url,
        "status": "pending",
      }
    });
    return true;
  }

  @override
  Future<bool> uploadProofOfAddress(
    File file,
    String uid,
  ) async {
    String url = await uploadFile(file, uid, "proffofaddress");
    // add identification to user document
    await _userDocsRef.doc(uid).update({
      "proofOfAddress": {
        "url": url,
        "status": "pending",
      }
    });
    return true;
  }

  Future<bool> addBackgroundInformation(
      BackgroundInformation backgroundInformation, String uid) async {
    await _userBgInfoRef
        .doc(uid)
        .set(backgroundInformation.toMap())
        .timeout(Duration(seconds: 10));
    return true;
  }

  Future<DocumentSnapshot<Object?>> getBackgroundInformation(String uid) async {
    return await _userBgInfoRef.doc(uid).get();
  }

  Future<QuerySnapshot<Object?>> getLevels() async {
    return await _levelInfoRef.get();
  }
}
