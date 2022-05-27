import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/size_const.dart';
import 'package:flutter_application_1/pages/apply/first_time/apply1.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';

class ApplySplash extends StatelessWidget {
  static const pageName = '/applySplash';
  const ApplySplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: -150,
                right: -300,
                child: Image.asset("assets/images/apply_splash.png",
                    height: kScreenHeight(context) * 0.5 + 120,
                    fit: BoxFit.cover),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            child: TextH1(title: "Apply", color: Colors.black),
                            alignment: Alignment.centerLeft),
                        Column(
                          children: [
                            Container(
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/apply_banner.png'))),
                            SizedBox(
                              height: 40,
                            ),
                            Text('Fast, affordable loans\nin minutes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Tell us about yourself by answering a series of questions, receive a loan outcome in under an hour and get cash to your account once approved.',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: kScreenWidth(context) * 0.8,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApplyScreen1()));
                            },
                            child: Text('Get started',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins')),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100))),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}
