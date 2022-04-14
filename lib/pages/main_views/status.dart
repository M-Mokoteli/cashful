import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/size_const.dart';
import 'package:flutter_application_1/models/loan_request_model.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';
import 'package:flutter_application_1/view_models/status_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:intl/intl.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

var boldFont = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600);

class _StatusScreenState extends State<StatusScreen> {
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  Widget _textLoadingDefault = Text("--");

  @override
  Widget build(BuildContext context) {
    return BaseView<StatusViewModel>(
        onModelReady: (model) => model.getUserLoan(),
        builder: (context, model, child) {
          return ApplyStepsCommon(
            bgImgUrl: "assets/images/notification_wave_bg.png",
            internalWidget: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextH1(title: "Status"),
                  ),
                  SingleChildScrollView(
                    child: Container(
                        height: 550,
                        width: kScreenWidth(context),
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: Column(children: [
                          SizedBox(height: 30),
                          Container(
                              width: 200,
                              height: 200,
                              child: Stack(children: <Widget>[
                                Container(
                                    child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          offset: Offset(0, 4),
                                          blurRadius: 10)
                                    ],
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    border: Border.all(
                                      color: Color.fromRGBO(243, 243, 243, 1),
                                      width: 7,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(200, 200)),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 60,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Outstanding balance',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.699999988079071),
                                                fontFamily: 'Inter',
                                                fontSize: 13,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.normal,
                                                height: 1),
                                          )),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          child: Column(children: [
                                            model.state == ViewState.Idle &&
                                                    model.loanRequest != null
                                                ? Text(
                                                    "R ${(model.loanRequest as LoanRequest).loanAmount}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0,
                                                            0,
                                                            0,
                                                            0.699999988079071),
                                                        fontFamily: 'Inter',
                                                        fontSize: 28,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1),
                                                  )
                                                : _textLoadingDefault
                                          ])),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          child:
                                              model.state == ViewState.Idle &&
                                                      model.loanRequest != null
                                                  ? Text(
                                                      "Due: ${_formatDate(DateTime.parse((model.loanRequest as LoanRequest).loanDate!).add(Duration(days: int.parse((model.loanRequest as LoanRequest).paymentTime))).toString())}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kPrimaryBlue,
                                                          fontFamily: 'Inter',
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 1),
                                                    )
                                                  : _textLoadingDefault),
                                    ],
                                  ),
                                )),
                              ])),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 29),
                            child: Row(children: [
                              Text('Loan details', style: boldFont)
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Loan amount'),
                                    SizedBox(width: 80),
                                    model.state == ViewState.Idle &&
                                            model.loanRequest != null
                                        ? Text(
                                            "R ${(model.loanRequest as LoanRequest).loanAmount}",
                                            style: boldFont,
                                          )
                                        : _textLoadingDefault
                                  ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Interest'),
                                  SizedBox(width: 116),
                                  model.state == ViewState.Idle &&
                                          model.loanRequest != null
                                      ? Text(
                                          "R ${(double.parse((model.loanRequest as LoanRequest).totalRepayable) - double.parse((model.loanRequest as LoanRequest).loanAmount)).toStringAsFixed(2)}",
                                          style: boldFont,
                                        )
                                      : _textLoadingDefault
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Loan term'),
                                  SizedBox(width: 100),
                                  model.state == ViewState.Idle &&
                                          model.loanRequest != null
                                      ? Text(
                                          "${(model.loanRequest as LoanRequest).paymentTime} days",
                                          style: boldFont,
                                        )
                                      : _textLoadingDefault
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Loan date'),
                                  SizedBox(width: 116),
                                  model.state == ViewState.Idle &&
                                          model.loanRequest != null
                                      ? Text(
                                          "${_formatDate((model.loanRequest as LoanRequest).loanDate!)}",
                                          style: boldFont,
                                        )
                                      : _textLoadingDefault
                                ],
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ])),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String _formatDate(String date) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    return dateFormat.format(DateTime.parse(date));
  }
}
