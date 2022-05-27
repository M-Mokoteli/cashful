import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';

import 'for_sme3.dart';

class ApplyForSME2 extends StatefulWidget {
  static const pageName = "applyForSME2";

  const ApplyForSME2({Key? key}) : super(key: key);

  @override
  _ApplyForSME1State createState() => _ApplyForSME1State();
}

class _ApplyForSME1State extends State<ApplyForSME2> {
  var viewModel = locator<ApplyViewModel>();

  String? investmentToDate;
  final TextEditingController monthlyBusinessRevenue = TextEditingController();
  final TextEditingController monthlyBusinessExpenses = TextEditingController();

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
                        child: Text(
                            'How much has been invested into your business to date?',
                            style: myFont)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'R0 - R2499',
                        groupValue: investmentToDate,
                        onChanged: (value) {
                          setState(() {
                            investmentToDate = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'R0 - R2499',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                          activeColor: Colors.black,
                          value: 'R2500 - R4999',
                          groupValue: investmentToDate,
                          onChanged: (value) {
                            setState(() {
                              investmentToDate = value as String;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text('R2500 - R4999', style: myFont)
                    ]),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'R5000 - R7499',
                        groupValue: investmentToDate,
                        onChanged: (value) {
                          setState(() {
                            investmentToDate = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'R5000 - R7499',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'R7500 - R9999',
                        groupValue: investmentToDate,
                        onChanged: (value) {
                          setState(() {
                            investmentToDate = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'R7500 - R9999',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'R10000 and above',
                        groupValue: investmentToDate,
                        onChanged: (value) {
                          setState(() {
                            investmentToDate = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('R10000 and above', style: myFont)
                    ]),
                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.only(right: 40),
                        child: Text(
                            'How much does your business make per month?',
                            style: myFont)),
                    SizedBox(width: 4),
                    SizedBox(
                      width: 250,
                    ),
                    TextField(
                      controller: monthlyBusinessRevenue,
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
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                            "What are your business's monthly expenses?",
                            style: myFont)),
                    SizedBox(width: 4),
                    SizedBox(
                      width: 250,
                    ),
                    TextField(
                      controller: monthlyBusinessExpenses,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(5),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(alignment: Alignment.center, child: Text('3/5')),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  _onNext() {
    if (investmentToDate == null ||
        monthlyBusinessRevenue.text == "" ||
        monthlyBusinessExpenses.text == "") {
      AppHelper.showSnackBar("Please select all required fields", context);
    } else {
      viewModel.backgroundInformation.investmentToDate = investmentToDate;
      viewModel.backgroundInformation.businessrevenueMonthly =
          monthlyBusinessRevenue.text;
      viewModel.backgroundInformation.businessExpenceMonthly =
          monthlyBusinessExpenses.text;
      Navigator.of(context).pushNamed(ApplyForSME3.pageName);
    }
  }
}
