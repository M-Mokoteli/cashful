import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
              child: TextH1(title: "Help"),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      SizedBox(height: 0),
                      Container(
                          child: Text("Have a question? We're here to help",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          await launchUrlString("tel://+27 83 958 7442");
                        },
                        child: Row(children: [
                          Image(
                            image: AssetImage('assets/images/whatsapp.png'),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 20),
                          Container(child: Text('Whatsapp support'))
                        ]),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          await launchUrlString('https://www.cashful.me/faq');
                        },
                        child: Row(children: [
                          Image(
                            image: AssetImage('assets/images/globe.png'),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(child: Text('Frequently asked questions'))
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Container(
                    child: Text(
                  'Follow us on social media',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () async {
                      await launchUrlString(
                          'http://www.facebook.com/cashful.me');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: AssetImage('assets/images/facebook.png'),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(
                  width: 40,
                ),
                InkWell(
                    onTap: () async {
                      await launchUrlString(
                          'http://www.linkedin.com/company/cashful');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: AssetImage('assets/images/linkedin.png'),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
