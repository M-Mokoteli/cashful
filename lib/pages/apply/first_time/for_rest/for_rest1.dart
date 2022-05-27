import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';

import 'for_rest2.dart';

class ApplyForRest1 extends StatefulWidget {
  static const pageName = "applyForRest1";

  const ApplyForRest1({Key? key}) : super(key: key);

  @override
  _ApplyForRest1State createState() => _ApplyForRest1State();
}

class _ApplyForRest1State extends State<ApplyForRest1> {
  var viewModel = locator<ApplyViewModel>();
  String? incomeSourceValue;
  final TextEditingController monthlyIncome = TextEditingController();
  final TextEditingController monthlyExpenses = TextEditingController();

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
                        child: Text('What is your main source of income?',
                            style: myFont)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Salary',
                        groupValue: incomeSourceValue,
                        onChanged: (value) {
                          setState(() {
                            incomeSourceValue = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Salary',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                          activeColor: Colors.black,
                          value: 'Savings',
                          groupValue: incomeSourceValue,
                          onChanged: (value) {
                            setState(() {
                              incomeSourceValue = value as String;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Savings', style: myFont)
                    ]),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Inheritance/Allowance',
                        groupValue: incomeSourceValue,
                        onChanged: (value) {
                          setState(() {
                            incomeSourceValue = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Inheritance/Allowance',
                        style: myFont,
                      )
                    ]),
                    Row(children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Investments',
                        groupValue: incomeSourceValue,
                        onChanged: (value) {
                          setState(() {
                            incomeSourceValue = value as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Investments',
                        style: myFont,
                      )
                    ]),
                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.only(right: 40),
                        child: Text('How much is your monthly income?',
                            style: myFont)),
                    SizedBox(width: 4),
                    SizedBox(
                      width: 250,
                    ),
                    Container(
                      width: 270,
                      margin: EdgeInsets.only(right: 18),
                      child: TextField(
                        controller: monthlyIncome,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(5),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            )),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text("How much are your monthly expenses?",
                            style: myFont)),
                    SizedBox(width: 4),
                    Container(
                      width: 270,
                      margin: EdgeInsets.only(right: 20),
                      child: TextField(
                        controller: monthlyExpenses,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(5),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            )),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(alignment: Alignment.center, child: Text('2/5')),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  _onNext() async {
    if (incomeSourceValue == null ||
        monthlyIncome.text == "" ||
        monthlyExpenses.text == "") {
      AppHelper.showSnackBar("Select required fields", context);
    } else {
      viewModel.backgroundInformation.monthlyIncome = monthlyIncome.text;
      viewModel.backgroundInformation.monthlyExpense = monthlyExpenses.text;
      viewModel.backgroundInformation.sourceOfIncome = incomeSourceValue;
      Navigator.of(context).pushNamed(ApplyForRest2.pageName);
    }
  }
}
