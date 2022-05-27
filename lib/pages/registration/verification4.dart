import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/configs/size_const.dart';
import 'package:flutter_application_1/models/bank_detail_model.dart';
import 'package:flutter_application_1/models/mtn_detail.dart';
import 'package:flutter_application_1/models/payment_info_model.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/pages/main_views/messages.dart';
import 'package:flutter_application_1/pages/registration/add_bank_account.dart';
import 'package:flutter_application_1/pages/verification/pending_verification.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/view_models/verification_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:provider/provider.dart';

class VerificationPage4 extends StatefulWidget {
  static const pageName = "/verificationPage4";

  const VerificationPage4({Key? key}) : super(key: key);

  @override
  _VerificationPage4State createState() => _VerificationPage4State();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _VerificationPage4State extends State<VerificationPage4> {
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController registeredNames = TextEditingController();

  String? _paymentMethodAdded;
  PaymentInfo? paymentInfo;
  late double _buttonWidth = 200;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = locator<VerificationViewModel>();
    return BaseView<VerificationViewModel>(builder: (context, model, child) {
      if (model.state == ViewState.Busy) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _buttonWidth = 50;
          });
        });
      }
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: kPrimaryBlue,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextH1(title: "Payment"),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              'Setup an account to which funds will be deposited and paid',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return dialog();
                                          });
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_paymentMethodAdded == "Mtn") ...[
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
                                  SizedBox(height: 30),
                                  InkWell(
                                    onTap: () async {
                                      BankDetail? result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddBankAccountScreen()));

                                      if (result != null) {
                                        setState(() {
                                          _paymentMethodAdded = "Bank";
                                        });
                                        paymentInfo =
                                            PaymentInfo(bankDetail: result);
                                      }
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (_paymentMethodAdded ==
                                              "Bank") ...[
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
                                              margin: EdgeInsets.only(left: 5),
                                              child: Image(
                                                  width: 60,
                                                  height: 40,
                                                  fit: BoxFit.fitWidth,
                                                  image: AssetImage(
                                                      'assets/images/std_bank.png'))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'EFT Transfer',
                                            style: boldFont,
                                          ),
                                        ]),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                              'Please ensure you only add a South African account that is in your own name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(height: 20),
                          // Text('Add at least one account',
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 14,
                          //         color: Colors.red)),
                          SizedBox(height: 40),

                          Consumer<UserViewModel>(
                            builder: (context, value, child) =>
                                AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                              width: _buttonWidth,
                              height: 50,
                              child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  color: kPrimaryBlue,
                                  disabledColor: kBgLight,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  //             RoundedRectangleBorder>(
                                  //         RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(100))),
                                  // style
                                  //   : ButtonStyle(
                                  //     backgroundColor:
                                  //         MaterialStateProperty.all(kPrimaryBlue),
                                  //     shape: MaterialStateProperty.all<
                                  //             RoundedRectangleBorder>(
                                  //         RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(100))),
                                  //   ),
                                  child: model.state == ViewState.Busy
                                      ? SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Text('Complete registration'),
                                  onPressed: _paymentMethodAdded == null
                                      ? null
                                      : () async {
                                          var result = await viewModel
                                              .addPaymentInfo(paymentInfo!);
                                          if (result) {
                                            setState(() {
                                              _buttonWidth = 200;
                                            });
                                            // value.setUser(user);
                                            Navigator.pushReplacementNamed(
                                                context,
                                                PendingVerificationPage
                                                    .pageName);
                                          } else {
                                            setState(() {
                                              _buttonWidth = 200;
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Something went wrong try again")));
                                              });
                                            });
                                          }
                                        }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      );
    });
  }

  dialog() {
    var _formKey = GlobalKey<FormState>();
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
                  Text('Add MTN account',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (value) => AppHelper.requiredValidator(value),
                    controller: registeredNames,
                    decoration: InputDecoration(
                      labelText: 'Registered Name',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: mobileNumber,
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
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                child: Text('Finish'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    paymentInfo = PaymentInfo(
                        mtnDetail: MtnDetail(
                            accountNumber: mobileNumber.text,
                            fullName: registeredNames.text));
                    Navigator.pop(context);
                    setState(() {
                      _paymentMethodAdded = "Mtn";
                    });
                  }
                  // uploadMTNAccountDetails();
                }),
          )
        ]);
    return dialog;
  }
}
