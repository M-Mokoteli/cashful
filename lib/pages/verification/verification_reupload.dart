import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/configs/size_const.dart';
import 'package:flutter_application_1/models/documents_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/verification/bank_statement_reupload.dart';
import 'package:flutter_application_1/pages/verification/id_reupload.dart';
import 'package:flutter_application_1/pages/verification/proof_of_address_reupload.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:provider/provider.dart';

class VerificationReuploadPage extends StatelessWidget {
  final userVm = locator<UserViewModel>();
  static const pageName = "verificationReupload";
  @override
  Widget build(BuildContext context) {
    return ApplyStepsCommon(
        showBack: false,
        internalWidget: Column(
          children: [
            SizedBox(height: 60),
            TextH1(title: "Verification"),
            Expanded(
                child: Container(
              width: kScreenWidth(context),
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              margin: EdgeInsets.only(
                left: 20,
                top: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text('Your information is being verified.\nwe\'ll notify you when verification has\nbeen completed',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 60,
                  ),
                  Consumer<UserViewModel>(builder: (context, model, child) {
                    return _stepperWidget(context, model.user ?? null);
                  })
                ],
              ),
            )),
          ],
        ));
  }

  Widget _stepperWidget(context, User? user) {
    Function? onTap;
    log(user?.firstName ?? 'null');
    VerificationDocuments? verificationDocuments = user?.verificationDocuments ?? null;

    var bankStatus = verificationDocuments?.bankStatement?['status'] ?? 'rejected';
    var idStatus = verificationDocuments?.idCard?['status'] ?? 'rejected';
    var addressStatus = verificationDocuments?.proofOfAddress?['status'] ?? 'rejected';

    return Column(
      children: [
        _stepWidget(Icons.file_present, 'Identity document', idStatus,
            idStatus == "rejected" ? () => _onTapId(context) : onTap),
        SizedBox(height: 40),
        _stepWidget(Icons.file_present, 'Bank statement', bankStatus,
            bankStatus == "rejected" ? () => _onTapBankStatement(context) : onTap),
        SizedBox(height: 40),
        _stepWidget(Icons.file_present, 'Proof of address', addressStatus,
            addressStatus == "rejected" ? () => _onTapaddress(context) : onTap),
      ],
    );
  }

  _onTapBankStatement(context) {
    Navigator.of(context).pushNamed(ReuploadBankStatementPage.pageName);
  }

  _onTapId(context) {
    Navigator.of(context).pushNamed(ReuploadIDPage.pageName);
  }

  _onTapaddress(context) {
    Navigator.of(context).pushNamed(ReuploadProofOfAddressPage.pageName);
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
