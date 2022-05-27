import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/models/loan_request_model.dart';
import 'package:flutter_application_1/pages/apply/apply_final_step.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/main_views/home_with_bottom_navbar.dart';

class LoanApplicationInfoPage extends StatefulWidget {
  static const pageName = "loanApplicationInfoPage";
  final bool firstTime;

  LoanApplicationInfoPage({Key? key, this.firstTime = false}) : super(key: key);

  @override
  _LoanApplicationInfoPageState createState() =>
      _LoanApplicationInfoPageState();
}

class _LoanApplicationInfoPageState extends State<LoanApplicationInfoPage> {
  // var viewModel = locator<LoanRequest>();

  String? loanType;
  final TextEditingController loanDetails = TextEditingController();

  var myFont = (TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return ApplyStepsCommon(
      internalWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 120),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
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
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                            'Are you applying for a personal or business loan?',
                            style: myFont)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Personal',
                        groupValue: loanType,
                        onChanged: (value) {
                          setState(() {
                            loanType = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Personal',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                          activeColor: Colors.black,
                          value: 'Business',
                          groupValue: loanType,
                          onChanged: (value) {
                            setState(() {
                              loanType = value as String;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Business', style: myFont)
                    ]),
                    SizedBox(height: 10),
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                            'Please state the purpose of the loan in as much detail as possible',
                            style: myFont)),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                    ),
                    TextField(
                      controller: loanDetails,
                      maxLines: 10,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          isDense: false,
                          contentPadding: const EdgeInsets.all(20),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.firstTime)
                Container(
                    margin: EdgeInsets.only(right: 75), child: Text('5/5')),
              Container(
                margin: EdgeInsets.only(right: 40),
                width: 100,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  onPressed: () {
                    if (loanType == null || loanDetails.text == "") {
                      AppHelper.showSnackBar(
                          "Please fill all required fields", context);
                      return;
                    }
                    LoanRequest loanRequest = LoanRequest(
                        loanType: loanType!,
                        loanAmount: '',
                        loanDetail: loanDetails.text,
                        totalRepayable: '',
                        loanStatus: 'pending',
                        paymentTime: '');

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        ApplyFinalStep.pageName,
                        ModalRoute.withName(HomeWithBottomNavBar.pageName),
                        arguments: loanRequest);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
