import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_models/splash_view_model.dart';
import '../../configs/locator.dart';
import '../../models/user_model.dart';

class PayStdBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var boldFont = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600);

    User? user = locator<SplashViewModel>().user;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          titleSpacing: 30,
          automaticallyImplyLeading: true,
          backgroundColor: Color.fromRGBO(246, 246, 246, 1),
          toolbarHeight: 100,
          title: new Text(
            'Pay',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 25,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                height: 1),
          ),
        ),
        body: Container(
          color: Color.fromRGBO(246, 246, 246, 1),
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                    'Sign in to your bank and make a deposit with the following information',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter'))),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recepient'),
                        SizedBox(width: 40),
                        Text("Cashful Co", style: boldFont)
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bank'),
                      SizedBox(width: 40),
                      Text("FNB", style: boldFont)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Account number'),
                      SizedBox(width: 40),
                      Text("62925756887", style: boldFont)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Account type'),
                      SizedBox(width: 40),
                      Text("Cheque", style: boldFont)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Branch Code'),
                      SizedBox(width: 40),
                      Text('250655', style: boldFont)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Reference number'),
                      SizedBox(width: 40),
                      Text(user?.referenceNumber.toUpperCase() ?? "",
                          style: boldFont)
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Text(
                      'If you do not see a reference number, please update your bank account details in Settings',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
