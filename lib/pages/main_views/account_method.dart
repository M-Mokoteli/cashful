import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/configs/size_const.dart';
import 'package:flutter_application_1/models/bank_detail_model.dart';
import 'package:flutter_application_1/models/mtn_detail.dart';
import 'package:flutter_application_1/models/payment_info_model.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/pages/main_views/bank_account_method.dart';
import 'package:flutter_application_1/pages/main_views/status.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/payment_methods_view_model.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:provider/provider.dart';

class AccountMethod extends StatefulWidget {
  static const pageName = "paymentMethods";
  @override
  AccountMethodState createState() => AccountMethodState();
}

class AccountMethodState extends State<AccountMethod> {
  var viewModel = locator.get<PaymentMethodViewModel>();
  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/images/home_wave_bg.png",
              height: kScreenHeight(context) * 0.4,
              fit: BoxFit.fill,
              width: kScreenWidth(context),
            ),
            Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                TextH1(title: "Payment methods"),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ...[
                                    InkWell(
                                      onTap: () {
                                        MtnDetail mtnDetail =
                                            model.user!.mtnDetail ??
                                                MtnDetail(
                                                    fullName: "",
                                                    accountNumber: "");
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                _updateDialog(mtnDetail));
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ...[
                                              if (model.user!.mtnDetail != null)
                                                Image.asset(
                                                  "assets/images/check_star.png",
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit.cover,
                                                ),
                                              SizedBox(
                                                width: 10,
                                              )
                                            ],
                                            Container(
                                                child: Image(
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.fitWidth,
                                                    image: AssetImage(
                                                        'assets/images/mtn.png'))),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                                child: Text(
                                              'MTN Mobile Money',
                                              style: boldFont,
                                            ))
                                          ]),
                                    ),
                                  ],
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ...[
                                    InkWell(
                                      onTap: () {
                                        BankDetail bankDetail =
                                            model.user!.bankDetail ??
                                                BankDetail(
                                                    hodlerName: "",
                                                    accountNumber: "",
                                                    accountType: "",
                                                    bankName: "",
                                                    bankCode: "");
                                        Navigator.of(context).pushNamed(
                                            UpdateBankAccountScreen.pageName,
                                            arguments: bankDetail);
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            if (model.user!.bankDetail != null)
                                              Image.asset(
                                                "assets/images/check_star.png",
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.cover,
                                              ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                child: Image(
                                                    width: 60,
                                                    height: 40,
                                                    fit: BoxFit.fitWidth,
                                                    image: AssetImage(
                                                        'assets/images/std_bank.png'))),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('EFT Transfer',
                                                style: boldFont),
                                          ]),
                                    ),
                                    // SizedBox(height: 30),
                                  ],
                                ]),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Container(
                      child: Text(
                    'Note: you can have one payment method at a time, updating one removes the other',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  )),
                )
              ],
            ),
          ],
        ),
      );
    });
  }

  _updateDialog(MtnDetail mtnDetail) {
    var _formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var mobileNumberController = TextEditingController();
    nameController.text = mtnDetail.fullName;
    mobileNumberController.text = mtnDetail.accountNumber;
    AlertDialog dialog = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Container(
          height: 250,
          width: kScreenWidth(context),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Update MTN account',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (value) => AppHelper.requiredValidator(value),
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Registered Name',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: mobileNumberController,
                    validator: (value) => AppHelper.requiredValidator(value),
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ]),
          ),
        ),
        actions: [
          Consumer<PaymentMethodViewModel>(builder: (context, value, child) {
            return Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  child: value.state == ViewState.Busy
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : Text('Update'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var result = await viewModel.updatePaymentInfo(
                          PaymentInfo(
                              mtnDetail: MtnDetail(
                                  accountNumber: mobileNumberController.text,
                                  fullName: nameController.text)));

                      Navigator.pop(context);
                      if (result) {
                        AppHelper.showSnackBar("Update successful", context);
                      } else {
                        AppHelper.showSnackBar(
                            "Update failed, try again.", context);
                      }
                    }
                  }),
            );
          })
        ]);
    return dialog;
  }
}
