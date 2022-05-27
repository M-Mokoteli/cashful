import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/apply/first_time/for_rest/for_rest1.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';

import 'for_sme/for_sme1.dart';

class ApplyScreen1 extends StatefulWidget {
  const ApplyScreen1({Key? key}) : super(key: key);

  @override
  _ApplyScreen1State createState() => _ApplyScreen1State();
}

class _ApplyScreen1State extends State<ApplyScreen1> {
  String? creditScoreValue;
  String? smallBusinessOwnerValue;
  String? employmentStatusValue;
  final TextEditingController creditScoreAmount = TextEditingController();

  bool _isVisible = false;
  bool _isVisible2 = false;
  bool _forBusiness = true;

  var myFont = (TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold));
  var viewModel = locator<ApplyViewModel>();

  @override
  void initState() {
    super.initState();
  }

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
                    padding: EdgeInsets.only(top: 40, bottom: 40),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 100),
                            child: Text('Do you have a credit score?',
                                style: myFont)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: 'Yes',
                              groupValue: creditScoreValue,
                              onChanged: (value) {
                                setState(() {
                                  creditScoreValue = value as String;
                                  _isVisible = true;
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(children: [
                            Radio(
                                activeColor: Colors.black,
                                value: 'No',
                                groupValue: creditScoreValue,
                                onChanged: (value) {
                                  setState(() {
                                    creditScoreValue = value as String;
                                    _isVisible = false;
                                  });
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            Text('No', style: myFont)
                          ]),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(right: 112),
                          child: Visibility(
                            visible: _isVisible,
                            child: Text('What is your credit score?',
                                style: myFont),
                          ),
                        ),
                        SizedBox(width: 4),
                        SizedBox(
                          width: 300,
                          child: Visibility(
                            visible: _isVisible,
                            child: TextField(
                              controller: creditScoreAmount,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(5),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                            margin: EdgeInsets.only(right: 60),
                            child: Text('Are you a small business owner?',
                                style: myFont)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: 'Yes',
                              groupValue: smallBusinessOwnerValue,
                              onChanged: (value) {
                                setState(() {
                                  smallBusinessOwnerValue = value as String;
                                  _forBusiness = true;
                                  _isVisible2 = false;
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(children: [
                            Radio(
                                activeColor: Colors.black,
                                value: 'No',
                                groupValue: smallBusinessOwnerValue,
                                onChanged: (value) {
                                  setState(() {
                                    smallBusinessOwnerValue = value as String;
                                    _forBusiness = false;
                                    _isVisible2 = true;
                                  });
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            Text('No', style: myFont),
                          ]),
                        ),
                        SizedBox(height: 10),
                        Container(
                            margin: EdgeInsets.only(right: 56),
                            child: Visibility(
                                visible: _isVisible2,
                                child: Text('What is your employment status?',
                                    style: myFont))),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: _isVisible2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(children: [
                              Radio(
                                activeColor: Colors.black,
                                value: 'Unemployed',
                                groupValue: employmentStatusValue,
                                onChanged: (value) {
                                  setState(() {
                                    employmentStatusValue = value as String;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Unemployed',
                                style: myFont,
                              )
                            ]),
                          ),
                        ),
                        Visibility(
                          visible: _isVisible2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(children: [
                              Radio(
                                activeColor: Colors.black,
                                value: 'Employed',
                                groupValue: employmentStatusValue,
                                onChanged: (value) {
                                  setState(() {
                                    employmentStatusValue = value as String;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Employed',
                                style: myFont,
                              )
                            ]),
                          ),
                        ),
                        Visibility(
                          visible: _isVisible2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(children: [
                              Radio(
                                activeColor: Colors.black,
                                value: 'Freelancer',
                                groupValue: employmentStatusValue,
                                onChanged: (value) {
                                  setState(() {
                                    employmentStatusValue = value as String;
                                    _isVisible = _isVisible;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Freelancer',
                                style: myFont,
                              )
                            ]),
                          ),
                        ),
                        Visibility(
                          visible: _isVisible2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(children: [
                              Radio(
                                activeColor: Colors.black,
                                value: 'Student',
                                groupValue: employmentStatusValue,
                                onChanged: (value) {
                                  setState(() {
                                    employmentStatusValue = value as String;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Student',
                                style: myFont,
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(alignment: Alignment.center, child: Text('1/5')),
              SizedBox(height: 20),
            ]));
  }

  _onNext() async {
    // uploadBackgroundInfo();
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ApplyForRest1()));
    // return;
    if (creditScoreValue == null || null == smallBusinessOwnerValue) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select all required fields")));
    } else if (creditScoreValue == "Yes" && creditScoreAmount.text == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter your credit score")));
    } else if (smallBusinessOwnerValue == "No" &&
        employmentStatusValue == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Select employment status")));
    } else {
      // Set respective values
      viewModel.backgroundInformation.creditScoreValue = creditScoreAmount.text;
      viewModel.backgroundInformation.isSmallBusinessOwner =
          smallBusinessOwnerValue == "Yes";
      viewModel.backgroundInformation.isCreditScorePresent =
          creditScoreValue == "Yes";
      viewModel.backgroundInformation.employmentStatus = employmentStatusValue;
      if (_forBusiness) {
        Navigator.pushNamed(context, ApplyForSME1.pageName);
      } else {
        Navigator.pushNamed(context, ApplyForRest1.pageName);
      }
    }
    return;
  }
}
