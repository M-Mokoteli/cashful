import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';

import 'for_sme2.dart';

class ApplyForSME1 extends StatefulWidget {
  static const pageName = "applyForSME1";
  const ApplyForSME1({Key? key}) : super(key: key);

  @override
  _ApplyForSME1State createState() => _ApplyForSME1State();
}

class _ApplyForSME1State extends State<ApplyForSME1> {
  final TextEditingController businessOffering = TextEditingController();
  final TextEditingController durationOfOperation = TextEditingController();
  String? financingValue;

  var myFont = (TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold));

  var viewModel = locator<ApplyViewModel>();

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
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Text(
                              'What services/products does your business offer?',
                              style: myFont)),
                      SizedBox(width: 4),
                      SizedBox(
                        width: 250,
                      ),
                      TextField(
                        controller: businessOffering,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(5),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            )),
                      ),
                      SizedBox(height: 10),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                              'How long has your business been operational?',
                              style: myFont)),
                      SizedBox(width: 4),
                      SizedBox(
                        width: 250,
                      ),
                      TextField(
                        controller: durationOfOperation,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(5),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            )),
                      ),
                      SizedBox(height: 10),
                      Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text('How did you finance your business?',
                              style: myFont)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Radio(
                          activeColor: Colors.black,
                          value: 'Personal savings',
                          groupValue: financingValue,
                          onChanged: (value) {
                            setState(() {
                              financingValue = value as String;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Personal savings',
                          style: myFont,
                        )
                      ]),
                      Row(children: [
                        Radio(
                            activeColor: Colors.black,
                            value: 'Group savings/stokvel',
                            groupValue: financingValue,
                            onChanged: (value) {
                              setState(() {
                                financingValue = value as String;
                              });
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Group savings/stokvel', style: myFont)
                      ]),
                      Row(children: [
                        Radio(
                          activeColor: Colors.black,
                          value: 'Friends/family',
                          groupValue: financingValue,
                          onChanged: (value) {
                            setState(() {
                              financingValue = value as String;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Friends/family',
                          style: myFont,
                        )
                      ]),
                      Row(children: [
                        Radio(
                          activeColor: Colors.black,
                          value: 'Bank loan',
                          groupValue: financingValue,
                          onChanged: (value) {
                            setState(() {
                              financingValue = value as String;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Bank loan',
                          style: myFont,
                        )
                      ]),
                      Row(children: [
                        Radio(
                          activeColor: Colors.black,
                          value: 'Other',
                          groupValue: financingValue,
                          onChanged: (value) {
                            setState(() {
                              financingValue = value as String;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Other', style: myFont)
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(alignment: Alignment.center, child: Text('2/5')),
            SizedBox(height: 20),
          ],
        ));
  }

  _onNext() {
    if (financingValue == null ||
        businessOffering.text == "" ||
        durationOfOperation.text == "") {
      AppHelper.showSnackBar("Please select all required fields", context);
    } else {
      viewModel.backgroundInformation.businessOffering = businessOffering.text;
      viewModel.backgroundInformation.lengthOfOperation =
          durationOfOperation.text;
      viewModel.backgroundInformation.sourceOfFinancing = financingValue;
      Navigator.of(context).pushNamed(ApplyForSME2.pageName);
    }
  }
}
