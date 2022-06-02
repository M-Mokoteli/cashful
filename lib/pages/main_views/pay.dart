import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/main_views/paymtn.dart';
import 'package:flutter_application_1/pages/main_views/paystdbank.dart';
import 'package:flutter_application_1/pages/main_views/status.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  Widget build(BuildContext context) {
    return ApplyStepsCommon(
      bgImgUrl: "assets/images/notification_wave_bg.png",
      internalWidget: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextH1(title: "Pay"),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Container(
                        child: Text('Payment methods',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PayMtn()));
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Image(
                                    height: 40,
                                    width: 40,
                                    image:
                                        AssetImage('assets/images/mtn.png'))),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                                child:
                                    Text('MTN Mobile Money', style: boldFont))
                          ]),
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayStdBank()));
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Image(
                                    width: 60,
                                    image: AssetImage(
                                        'assets/images/std_bank.png'))),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                child: Text(
                              'EFT Transfer',
                              style: boldFont,
                            ))
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40.0),
              child: Container(
                  child: Text(
                'Please note that we do not accept cash deposits or cheques.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              )),
            )
          ],
        ),
      ),
    );
  }
}
