import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/apply/apply_final_step.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';

class ApplyForRest4 extends StatefulWidget {
  static const pageName = "applyForRest4";

  const ApplyForRest4({Key? key}) : super(key: key);

  @override
  _ApplyForRest4State createState() => _ApplyForRest4State();
}

class _ApplyForRest4State extends State<ApplyForRest4> {
  var viewModel = locator<ApplyViewModel>();

  String loanType = '';
  final TextEditingController loanDetails = TextEditingController();
  final TextEditingController loanAmount = TextEditingController();

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
                    // SizedBox(height: 20),
                    // Container(
                    //     margin: EdgeInsets.only(right: 32),
                    //     child: Text('How much are you looking to borrow?',
                    //         style: myFont)),
                    // SizedBox(height: 10),
                    // TextField(
                    //   controller: loanAmount,
                    //   textAlign: TextAlign.left,
                    //   decoration: InputDecoration(
                    //       isDense: true,
                    //       border: UnderlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.black),
                    //       )),
                    // ),
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
              Container(margin: EdgeInsets.only(right: 75), child: Text('5/5')),
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
                    Navigator.of(context).pushNamed(ApplyFinalStep.pageName);
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
