import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/configs/size_const.dart';
import 'package:flutter_application_1/models/level_model.dart';
import 'package:flutter_application_1/models/loan_request_model.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/level_view_model.dart';
import 'package:flutter_application_1/view_models/loan_request_view_model.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:provider/provider.dart';

class ApplyFinalStep extends StatefulWidget {
  static const pageName = "/applyFinalStep";
  final LoanRequest _loanRequest;

  ApplyFinalStep(this._loanRequest);

  @override
  State<ApplyFinalStep> createState() => _ApplyFinalStepState();
}

class _ApplyFinalStepState extends State<ApplyFinalStep> {
  var viewModel = locator<LoanRequestViewModel>();

  int loanMinimumAmount = 100;
  int variableLoanAmount = 100;
  double loanAmount = 0;
  double loanValue = 0.0;
  var _returnDateIndex = 0;

  // var _showSlider = false;

  var _paymentDays = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<LevelViewModel>(
      builder: (context, levelVm, child) {
        return Consumer<UserViewModel>(builder: (context, userVM, child) {
          var user = userVM.user!;
          Level level = levelVm.getLevel(user.levelId);
          if (loanAmount < level.min) {
            loanAmount = level.min.toDouble();
          }
          loanMinimumAmount = level.min.toInt();
          variableLoanAmount = (level.max - level.min).toInt();
          _paymentDays = level.repayDates;
          return BaseView<LoanRequestViewModel>(
              builder: (context, model, child) {
            return Scaffold(
              body: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextH1(
                      title: "Apply",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      width: kScreenWidth(context),
                      height: kScreenHeight(context),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextH3(
                            title: "Select loan amount",
                            color: Colors.black,
                          ),
                          SizedBox(height: 20),
                          Text(
                            // "You qualify for an advance maximum of up to R600, please move the slider to select an amount",
                            //level?.name == 'level1' &&
                            (level.name == 'level1' && user.isFirstTimeBorrower)
                                ? "As a first time borrower, you qualify for an advance maximum of R${level.max}."
                                : "You qualify for an advance maximum of up to R${level.max}, please move the slider to select an amount",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                    width: 1, color: Colors.black26)),
                            child: TextH2(
                              title: "R${loanAmount.toStringAsFixed(0)}",
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 40),
                          if (level.min != level.max)
                            Row(
                              children: [
                                Text(
                                  "R${level.min}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  //child: Text("  ${loanValue / variableLoanAmount.toDouble()}    ${level.min}     ${level.max}    ${loanValue}   ${loanValue * variableLoanAmount}")
                                  child: Slider(
                                    min: 0.0,
                                    max: 1.0,
                                    divisions: 10,
                                    value: loanValue /
                                        variableLoanAmount.toDouble(),
                                    onChanged: (value) {
                                      setState(() {
                                        loanValue = value * variableLoanAmount;
                                        loanAmount =
                                            (loanMinimumAmount + loanValue);
                                      });
                                    },
                                    thumbColor: Colors.white,
                                    inactiveColor: kBgLight,
                                    activeColor: kPrimaryBlue,
                                  ),

                                  /*Slider(
                                    min: level.min.toDouble() /
                                        level.max.toDouble(),
                                    max: 1.0,
                                    // number divided by number is 1.0
                                    // level?.max.toDouble() ?? 1000 / (level?.max.toDouble() ?? 1000),
                                    divisions: 10,
                                    value: _loanValue / level.max.toDouble(),
                                    onChanged: (value) {
                                      setState(() {
                                        _loanValue = value * level.max;
                                      });
                                    },
                                    thumbColor: Colors.white,
                                    inactiveColor: kBgLight,
                                    activeColor: kPrimaryBlue,
                                  ),*/
                                ),
                                Text(
                                  "R${level.max}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: _paymentDays
                                  .map<Widget>((
                                    e,
                                  ) =>
                                      _daysWidget(
                                          "$e days", _paymentDays.indexOf(e)))
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Interest",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "(${level.interest * 100}%) R${(level.interest * loanAmount).toStringAsFixed(2)}")
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total repayable",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text(
                                  "R${(loanAmount + (level.interest * loanAmount)).toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 150,
                              height: 50,
                              child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(kPrimaryBlue),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40))),
                                  ),
                                  child: model.state == ViewState.Busy
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Submit',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ),
                                  onPressed: () {
                                    _submit(level.interest.toDouble());
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              )),
            );
          });
        });
      },
    );
  }

  _daysWidget(String text, index) {
    bool active = index == _returnDateIndex;
    return Container(
      width: 80,
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: active ? kPrimaryBlue : Colors.white,
          border: Border.all(
              color: active ? kPrimaryBlue : Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          setState(() {
            _returnDateIndex = index;
          });
        },
        child: Center(
          child: Text(text,
              style: TextStyle(
                  fontSize: 14, color: active ? Colors.white : Colors.black)),
        ),
      ),
    );
  }

  _submit(double interest) async {
    widget._loanRequest.loanAmount = loanAmount.toStringAsFixed(2);
    widget._loanRequest.paymentTime = _paymentDays[_returnDateIndex].toString();
    widget._loanRequest.totalRepayable =
        (loanAmount + (loanAmount * interest)).toStringAsFixed(2);
    var result = await viewModel.requestLoan(widget._loanRequest);
    if (result)
      showDialog(
        context: context,
        builder: (mContext) => AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 390,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/apply_dialog_icon.png",
                    width: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextH4(title: "Request submitted", color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Please allow up to 48 hours depending on your payment method",
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Pay early or on time to unlock more credit in future",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryBlue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                        ),
                        child: Text(
                          'Finish',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(mContext).pop();
                          Navigator.of(mContext).pop();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    else
      AppHelper.showSnackBar("Something went wrong try again", context);
  }
}
