import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/helper.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/pages/apply/first_time/apply_splash.dart';
import 'package:flutter_application_1/pages/apply/recurring/loan_application_info.dart';
import 'package:flutter_application_1/pages/base_view.dart';
import 'package:flutter_application_1/pages/main_views/help.dart';
import 'package:flutter_application_1/pages/main_views/pay.dart';
import 'package:flutter_application_1/view_models/loan_request_view_model.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'status.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var cardTextStyle = TextStyle(
      fontFamily: 'Poppins',
      letterSpacing: 1.2,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      height: 1);
  double dx = 0.5;

  @override
  Widget build(BuildContext context) {
    // style
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          dx = 1;
        });
      });
    });
    return BaseView<UserViewModel>(
      builder: (context, model, child) => Stack(
        children: <Widget>[
          Image.asset("assets/images/home_wave_bg.png",
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              fit: BoxFit.cover),
          AnimatedScale(
            scale: dx,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 1),
                    ),
                    Expanded(
                      child: Center(
                        child: GridView.count(
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          primary: false,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: InkWell(
                                  onTap: () async {
                                    var lrVM = locator<LoanRequestViewModel>();
                                    var loanReqeusts =
                                        await lrVM.getLoanRequests();
                                    if (lrVM.errorMessage == null) {
                                      var pendingOrapprovedLR =
                                          loanReqeusts.indexWhere(
                                        (element) =>
                                            element.loanStatus == 'pending' ||
                                            element.loanStatus == 'approved' ||
                                            element.loanStatus == 'overdue',
                                      );
                                      print(pendingOrapprovedLR);
                                      if (pendingOrapprovedLR != -1) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          AppHelper.showSnackBar(
                                              "You have already applied for a loan.",
                                              context);
                                        });
                                        return;
                                      }
                                    } else {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        AppHelper.showSnackBar(
                                            "Something went wrong try again.",
                                            context);
                                      });
                                      return;
                                    }
                                    if (model.user!.backgroundInformation ==
                                        null) {
                                      Navigator.pushNamed(
                                          context, ApplySplash.pageName);
                                    } else {
                                      Navigator.pushNamed(context,
                                          LoanApplicationInfoPage.pageName);
                                    }
                                  },
                                  child: _floatingHomeCard(
                                      'assets/images/apply.svg', 'Apply')),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StatusScreen()));
                                  },
                                  child: _floatingHomeCard(
                                      'assets/images/status.svg', 'Status')),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PayScreen()));
                                  },
                                  child: _floatingHomeCard(
                                      'assets/images/pay.svg', 'Pay')),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HelpScreen()));
                                  },
                                  child: _floatingHomeCard(
                                      'assets/images/help.svg', 'Help')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(top: 50, left: 20, child: TextH1(title: "Home"))
        ],
      ),
    );
  }

  Widget _floatingHomeCard(imageUrl, title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          imageUrl,
          height: 50,
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: cardTextStyle,
        )
      ],
    );
  }
}
