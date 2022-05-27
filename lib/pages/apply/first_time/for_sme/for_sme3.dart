import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/apply/recurring/loan_application_info.dart';
import 'package:flutter_application_1/pages/main_views/home_with_bottom_navbar.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';

class ApplyForSME3 extends StatefulWidget {
  static const pageName = "applyForSME3";
  const ApplyForSME3({Key? key}) : super(key: key);

  @override
  _ApplyForSME3State createState() => _ApplyForSME3State();
}

class _ApplyForSME3State extends State<ApplyForSME3> {
  var viewModel = locator<ApplyViewModel>();

  String? monthlySavings;
  String? stokvelValue;
  final TextEditingController stokvelContribution = TextEditingController();
  String? education;

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
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'R250 - R499',
                        style: myFont,
                      )
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
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'R500 and above',
                        style: myFont,
                      )
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
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Not yet', style: myFont)
                    ]),
                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.only(right: 60),
                        child: Text('Are you part of a stokvel group?',
                            style: myFont)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Yes',
                        groupValue: stokvelValue,
                        onChanged: (value) {
                          setState(() {
                            stokvelValue = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Yes',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                          activeColor: Colors.black,
                          value: 'No',
                          groupValue: stokvelValue,
                          onChanged: (value) {
                            setState(() {
                              stokvelValue = value as String;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text('No', style: myFont)
                    ]),
                    SizedBox(height: 10),
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                            'How much is contributed on a regular basis?',
                            style: myFont)),
                    SizedBox(width: 4),
                    SizedBox(
                      width: 250,
                    ),
                    TextField(
                      controller: stokvelContribution,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(5),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                    SizedBox(height: 20),
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
    uploadBusy = true;
    if (monthlySavings == null || stokvelValue == null || education == null) {
      AppHelper.showSnackBar("Please select all required fields", context);
    } else if (stokvelValue == "Yes" && stokvelContribution.text == "") {
      AppHelper.showSnackBar("Enter stokvel contribution", context);
    } else {
      viewModel.backgroundInformation.savingMonthly = monthlySavings;
      viewModel.backgroundInformation.isPartOfStockvel = stokvelValue == "Yes";
      viewModel.backgroundInformation.stockvelContribution =
          stokvelContribution.text;
      viewModel.backgroundInformation.highestLevelOfEducation = education;
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
                                  HomeWithBottomNavBar.pageName,
                                ),
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
      // Navigator.of(context, rootNavigator: true).pop();
      // if (result) {}
      // Navigator.of(context).pushNamed(LoanApplicationInfoPage.pageName);
    }
  }
}
