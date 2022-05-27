import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';
import 'for_rest3.dart';

class ApplyForRest2 extends StatefulWidget {
  static const pageName = "applyForRest2";

  const ApplyForRest2({Key? key}) : super(key: key);

  @override
  _ApplyForRest3State createState() => _ApplyForRest3State();
}

class _ApplyForRest3State extends State<ApplyForRest2> {
  var viewModel = locator<ApplyViewModel>();

  String? stokvelValue;
  final TextEditingController stokvelContribution = TextEditingController();

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
                    SizedBox(height: 150),
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

  _onNext() async {
    if (stokvelValue == null) {
      AppHelper.showSnackBar("Please select all required fields", context);
    } else if (stokvelValue == "Yes" && stokvelContribution.text == "") {
      AppHelper.showSnackBar("Enter your stokvel contribution", context);
    } else {
      viewModel.backgroundInformation.isPartOfStockvel = stokvelValue == "Yes";
      viewModel.backgroundInformation.stockvelContribution =
          stokvelContribution.text;
      Navigator.of(context).pushNamed(ApplyForRest3.pageName);
    }
  }
}
