import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as currentUser;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/configs/size_const.dart';
import 'package:flutter_application_1/models/documents_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/main_views/home_with_bottom_navbar.dart';
import 'package:flutter_application_1/pages/verification/verification_reupload.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:provider/provider.dart';

class PendingVerificationPage extends StatefulWidget {
  static const pageName = "pendingVerification";

  @override
  State<PendingVerificationPage> createState() =>
      _PendingVerificationPageState();
}

class _PendingVerificationPageState extends State<PendingVerificationPage> {
  final userVm = locator<UserViewModel>();

  @override
  Widget build(BuildContext context) {
    return ApplyStepsCommon(
        showBack: false,
        internalWidget: Column(
          children: [
            SizedBox(height: 60),
            TextH1(title: "Verification"),
            Card(
              margin: EdgeInsets.all(20),
              child: Container(
                width: kScreenWidth(context),
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                margin: EdgeInsets.only(
                  left: 20,
                  top: 20,
                  right: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        'Your information is being verified.We\'ll notify you when verification has nbeen completed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 60,
                    ),
                    Consumer<UserViewModel>(builder: (context, model, child) {
                      log(model.user?.toJson() ?? 'null');
                      //problematic code here model.user will always be null

                      // var user = model.user;

                      return model.user == null
                          ? FutureBuilder(
                              builder: ((context, snapshot) {
                                return snapshot.data == null
                                    ? Container()
                                    : _stepperWidget(snapshot.data as User);
                              }),
                              future: forceGetUserData(),
                            )
                          : _stepperWidget(model.user!);

                      // _stepperWidget(model.user ??
                      //     User(
                      //         firstName: 'firstName',
                      //         lastName: 'lastName',
                      //         id: 'id',
                      //         address: 'address',
                      //         mobileNumber: 'mobileNumber',
                      //         dob: 'dob',
                      //         fcmToken: 'fcmToken'));
                    }),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  //Fix
  Future<User> forceGetUserData() async {
    var db = FirebaseFirestore.instance;
    var uid = currentUser.FirebaseAuth.instance.currentUser?.uid;
    var userService = UserService(db);

    var userSnapshot = await userService.getUser(uid!);
    var user = User.fromFirebase(userSnapshot);

    var documentSnapshot = await userService.getUserDocuments(uid);
    var documents = VerificationDocuments.fromFirebase(documentSnapshot);

    user.verificationDocuments = documents;

    return user;
  }

  String _getStatus(User user) {
    VerificationDocuments? verificationDocuments =
        user.verificationDocuments ?? null;

    var rejected = verificationDocuments == null
        ? true
        : verificationDocuments.bankStatement!['status'] == "rejected" ||
            verificationDocuments.idCard!['status'] == "rejected" ||
            verificationDocuments.proofOfAddress!['status'] == "rejected";
    var approved = verificationDocuments == null
        ? false
        : verificationDocuments.bankStatement!['status'] == "approved" &&
            verificationDocuments.idCard!['status'] == "approved" &&
            verificationDocuments.proofOfAddress!['status'] == "approved";
    return approved
        ? "approved"
        : rejected
            ? "rejected"
            : "pending";
  }

  Widget _stepperWidget(User user) {
    VerificationDocuments? verificationDocuments =
        user.verificationDocuments ?? null;
    var rejected = (verificationDocuments == null)
        ? true
        : verificationDocuments.bankStatement!['status'] == "rejected" ||
            verificationDocuments.idCard!['status'] == "rejected" ||
            verificationDocuments.proofOfAddress!['status'] == "rejected";
    var status = "pending";
    Function? onTap;
    if (rejected) {
      status = "rejected";
      onTap = () {
        Navigator.of(context).pushNamed(VerificationReuploadPage.pageName);
      };
    } else if ((verificationDocuments.bankStatement?['status'] ?? '') ==
            "approved" &&
        (verificationDocuments.idCard?['status'] ?? '') == "approved" &&
        (verificationDocuments.proofOfAddress?['status'] ?? '') == "approved") {
      status = "approved";
    }
    print(status);
    print(rejected);
    return Column(
      children: [
        _stepWidget(Icons.document_scanner, 'Submit documents', 'approved'),
        SizedBox(height: 40),
        _stepWidget(Icons.check_circle, 'Verification', status, onTap),
        SizedBox(
          height: 60,
        ),
        Container(
          width: kScreenWidth(context),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(
                  color: _getStatus(user) == "rejected"
                      ? Colors.redAccent
                      : Colors.black54),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            _getStatus(user) == "pending"
                ? "Your account is under review"
                : _getStatus(user) == "rejected"
                    ? "You have some rejected documents, click verification above and reupload"
                    : "Account verified",
            style: TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        if (_getStatus(user) != "pending" && _getStatus(user) != "rejected")
          SizedBox(
            width: kScreenWidth(context),
            height: 50,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeWithBottomNavBar.pageName, (route) => false);
              },
              color: kPrimaryBlue,
              child: Text(
                "Continue",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget _stepWidget(IconData icon, title, status, [onTap]) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kPrimaryBlue,
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Icon(
            status == 'approved'
                ? Icons.check_circle_rounded
                : status == "pending"
                    ? Icons.pending
                    : Icons.error_outline,
            color: status == 'approved'
                ? kPrimaryBlue
                : status == "pending"
                    ? Colors.orange
                    : Colors.red,
            size: 30,
          )
        ],
      ),
    );
  }
}
