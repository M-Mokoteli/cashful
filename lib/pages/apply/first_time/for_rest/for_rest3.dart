import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/apply/recurring/loan_application_info.dart';
import 'package:flutter_application_1/pages/main_views/home_with_bottom_navbar.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';

class ApplyForRest3 extends StatefulWidget {
  static const pageName = "applyForRest3";

  const ApplyForRest3({Key? key}) : super(key: key);

  @override
  _ApplyForRest3State createState() => _ApplyForRest3State();
}

class _ApplyForRest3State extends State<ApplyForRest3> {
  var viewModel = locator<ApplyViewModel>();

  String? education;
  String? monthlySavings;

  var myFont = (TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return ApplyStepsCommon(
      onNext: _onNext,
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
                        child: Text('What is your highest level of education?',
                            style: myFont)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Postgraduate',
                        groupValue: education,
                        onChanged: (value) {
                          setState(() {
                            education = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Postgraduate',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                          activeColor: Colors.black,
                          value: 'Undergraduate',
                          groupValue: education,
                          onChanged: (value) {
                            setState(() {
                              education = value as String;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Undergratuate', style: myFont)
                    ]),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Matric',
                        groupValue: education,
                        onChanged: (value) {
                          setState(() {
                            education = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Matric',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Elementary',
                        groupValue: education,
                        onChanged: (value) {
                          setState(() {
                            education = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Elementary',
                        style: myFont,
                      )
                    ]),
                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.only(right: 60),
                        child: Text('How much do you save per month?',
                            style: myFont)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'R1 - R99',
                        groupValue: monthlySavings,
                        onChanged: (value) {
                          setState(() {
                            monthlySavings = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'R1 - R99',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                          activeColor: Colors.black,
                          value: 'R100 - R249',
                          groupValue: monthlySavings,
                          onChanged: (value) {
                            setState(() {
                              monthlySavings = value as String;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text('R100 - R249', style: myFont)
                    ]),
                    Row(children: [
                      Radio(
                          activeColor: Colors.black,
                          value: 'R250 - R499',
                          groupValue: monthlySavings,
                          onChanged: (value) {
                            setState(() {
                              monthlySavings = value as String;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text('R250 - R499', style: myFont)
                    ]),
                    Row(children: [
                      Radio(
                          activeColor: Colors.black,
                          value: 'R500 and above',
                          groupValue: monthlySavings,
                          onChanged: (value) {
                            setState(() {
                              monthlySavings = value as String;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text('R500 and above', style: myFont)
                    ]),
                    Row(children: [
                      Radio(
                          activeColor: Colors.black,
                          value: 'Not yet',
                          groupValue: monthlySavings,
                          onChanged: (value) {
                            setState(() {
                              monthlySavings = value as String;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Not yet', style: myFont)
                    ]),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(alignment: Alignment.center, child: Text('4/5')),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  bool uploadBusy = false;
  bool result = false;
  StateSetter? _setState;
  _onNext() async {
    if (education == null || monthlySavings == null) {
      AppHelper.showSnackBar("Please select all required fields", context);
    } else {
      viewModel.backgroundInformation.highestLevelOfEducation = education;
      viewModel.backgroundInformation.savingMonthly = monthlySavings;
      Navigator.of(context).pushNamed(LoanApplicationInfoPage.pageName);
      print(viewModel.backgroundInformation.toJson());
      var dialog = AlertDialog(
        content: StatefulBuilder(builder: (context, StateSetter setState) {
          _setState = setState;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (uploadBusy) ...[
                        CircularProgressIndicator(
                          color: kPrimaryBlue,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextH3(
                          title: "Please wait",
                          color: Colors.black,
                        )
                      ] else if (!uploadBusy && result) ...[
                        Icon(
                          Icons.check_circle,
                          size: 50,
                          color: kPrimaryBlue,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Successfully uploaded information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                LoanApplicationInfoPage.pageName,
                                ModalRoute.withName(
                                    HomeWithBottomNavBar.pageName),
                                arguments: true);
                          },
                          color: kPrimaryBlue,
                          child: TextH4(
                            title: "Continue",
                            color: Colors.white,
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      );
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => dialog,
      );
      result = await viewModel.addBackgroundInfo();
      print(result);
      _setState!(() {
        uploadBusy = false;
      });
      if (!result) {
        Navigator.of(context).pop();
        AppHelper.showSnackBar("Something went wrong try again", context);
      } else {
        AppHelper.setRecurringFalse();
      }
    }
  }
}
