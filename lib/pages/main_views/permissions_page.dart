import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/main_views/home_with_bottom_navbar.dart';
import 'package:flutter_application_1/widgets/alert.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:flutter/gestures.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:usage_stats/usage_stats.dart';

class PermissionsPage extends StatefulWidget {
  static const pageName = "permissions";
  final fromApply = false;

  PermissionsPage(bool fromApply);

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage>
    with WidgetsBindingObserver {
  bool _storageAllowed = false;

  bool _usageAllowed = false;

  bool _phoneAllowed = false;

  bool _smsAllowed = false;

  bool _locationAllowed = false;

  bool _contactsAllowed = false;

  @override
  void initState() {
    _checkPermissions();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissions();
    }
  }

  _checkPermissions() async {
    // DataUsage.init(); // Only Required for Android
    // List<DataUsageModel> dataUsage = await DataUsage.dataUsageAndroid(
    //     withAppIcon:
    //         true, // if false `DataUsageModel.appIconBytes` will be null
    //     dataUsageType:
    //         DataUsageType.wifi, // DataUsageType.wifi | DataUsageType.mobile
    //     oldVersion:
    //         true // will be true for Android versions lower than 23 (MARSHMELLOW)
    //     );
    _storageAllowed = await permissionHandler.Permission.storage.status ==
        permissionHandler.PermissionStatus.granted;
    _phoneAllowed = await permissionHandler.Permission.phone.status ==
        permissionHandler.PermissionStatus.granted;
    _smsAllowed = await permissionHandler.Permission.sms.status ==
        permissionHandler.PermissionStatus.granted;
    _locationAllowed = await permissionHandler.Permission.location.status ==
        permissionHandler.PermissionStatus.granted;
    _contactsAllowed = await permissionHandler.Permission.contacts.status ==
        permissionHandler.PermissionStatus.granted;
    _usageAllowed = await UsageStats.checkUsagePermission() ?? false;
    setState(() {});
  }

  permissionsAllowed() async {
    _storageAllowed = await permissionHandler.Permission.storage.status ==
        permissionHandler.PermissionStatus.granted;
    _phoneAllowed = await permissionHandler.Permission.phone.status ==
        permissionHandler.PermissionStatus.granted;
    _smsAllowed = await permissionHandler.Permission.sms.status ==
        permissionHandler.PermissionStatus.granted;
    _locationAllowed = await permissionHandler.Permission.location.status ==
        permissionHandler.PermissionStatus.granted;
    _contactsAllowed = await permissionHandler.Permission.contacts.status ==
        permissionHandler.PermissionStatus.granted;
    _usageAllowed = await UsageStats.checkUsagePermission() ?? false;

    return _contactsAllowed &&
        _locationAllowed &&
        _phoneAllowed &&
        _smsAllowed &&
        _storageAllowed &&
        _usageAllowed;
  }

  @override
  Widget build(BuildContext context) {
    return ApplyStepsCommon(
        showBack: false,
        internalWidget: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.all(20),
                color: Colors.white,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextH4(
                        title:
                            "Cashful uses your data for lending decisions. In order to start using the app, you need to grant the following permissions:",
                        color: kPrimaryBlue,
                      ),
                    ),
                    ListTile(
                      title: TextH4(
                        title: "Storage",
                        color: Colors.black,
                      ),
                      trailing: _storageAllowed
                          ? Icon(
                              Icons.check_circle,
                              color: kPrimaryBlue,
                            )
                          : _storageAllowed
                              ? Icon(
                                  Icons.check_circle,
                                  color: kPrimaryBlue,
                                )
                              : InkWell(
                                  onTap: () async {
                                    await _grantStoragePermission();
                                  },
                                  child: Text("Allow")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 18),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Used to enable document and photo uploads as part of our identity verification process. We may request you to upload copies of documents as proof of income.",
                              style: TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: TextH4(
                        title: "Device",
                        color: Colors.black,
                      ),
                      trailing: _usageAllowed
                          ? Icon(
                              Icons.check_circle,
                              color: kPrimaryBlue,
                            )
                          : InkWell(
                              onTap: () async {
                                await _grantUsagePermission();
                              },
                              child: Text("Allow")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 18),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Used to understand your usage history",
                              style: TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: TextH4(
                        title: "Call",
                        color: Colors.black,
                      ),
                      trailing: _phoneAllowed
                          ? Icon(
                              Icons.check_circle,
                              color: kPrimaryBlue,
                            )
                          : _phoneAllowed
                              ? Icon(
                                  Icons.check_circle,
                                  color: kPrimaryBlue,
                                )
                              : InkWell(
                                  onTap: () async {
                                    await _grantPhonePermission();
                                  },
                                  child: Text("Allow")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Used to securely link your account to your device. Cashful will never send/receive calls from your device",
                              style: TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: TextH4(
                        title: "SMS",
                        color: Colors.black,
                      ),
                      trailing: _smsAllowed
                          ? Icon(
                              Icons.check_circle,
                              color: kPrimaryBlue,
                            )
                          : InkWell(
                              onTap: () async {
                                await _grantSMSPermission();
                              },
                              child: Text("Allow")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Used to understand your financial history",
                              style: TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: TextH4(
                        title: "Location",
                        color: Colors.black,
                      ),
                      trailing: _locationAllowed
                          ? Icon(
                              Icons.check_circle,
                              color: kPrimaryBlue,
                            )
                          : InkWell(
                              onTap: () async {
                                await _grantLocationPermission();
                              },
                              child: Text("Allow")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Used to ensure that you are the only person applying for a loan from your device",
                              style: TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: TextH4(
                        title: "Contacts",
                        color: Colors.black,
                      ),
                      trailing: _contactsAllowed
                          ? Icon(
                              Icons.check_circle,
                              color: kPrimaryBlue,
                            )
                          : _contactsAllowed
                              ? Icon(
                                  Icons.check_circle,
                                  color: kPrimaryBlue,
                                )
                              : InkWell(
                                  onTap: () async {
                                    await _grantContactsPermission();
                                  },
                                  child: Text("Allow")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Contact lists are used to determine whether you are eligible for our services. We use automated processing to understand your network relationships, and this also helps our fraud models verify your identity. ",
                              style: TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text.rich(TextSpan(
                            text:
                                "By clicking 'Continue', I have read and accept the ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrlString(
                                          'https://www.cashful.me/privacy-policy');
                                    }),
                              TextSpan(text: " and "),
                              TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrlString(
                                          'https://www.cashful.me/terms-and-condition');
                                    }),
                            ]))),
                    SizedBox(
                      height: 20,
                    ),
                    _contactsAllowed &&
                            _locationAllowed &&
                            _phoneAllowed &&
                            _smsAllowed &&
                            _storageAllowed &&
                            _usageAllowed
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            width: 200,
                            height: 50,
                            child: MaterialButton(
                              color: kPrimaryBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                if (widget.fromApply) {
                                  Navigator.pop(context, true);
                                } else {
                                  Navigator.of(context).pushReplacementNamed(
                                      HomeWithBottomNavBar.pageName);
                                }
                              },
                              child: TextH4(
                                title: "Continue",
                                color: Colors.white,
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  _showManualPermissionAlert() {
    var dialog = showPermissionDialog(context);
    showDialog(builder: (context) => dialog, context: context);
  }

  _grantLocationPermission() async {
    var _locationPermissionGranted =
        await permissionHandler.Permission.locationWhenInUse.request();
    if (_locationPermissionGranted ==
        permissionHandler.PermissionStatus.granted) {
      setState(() {
        _locationAllowed = true;
      });
    } else if (_locationPermissionGranted ==
        permissionHandler.PermissionStatus.permanentlyDenied) {
      _showManualPermissionAlert();
    }
  }

  _grantContactsPermission() async {
    var _contactPermissionGranted =
        await permissionHandler.Permission.contacts.request();

    if (_contactPermissionGranted ==
        permissionHandler.PermissionStatus.granted) {
      setState(() {
        _contactsAllowed = true;
      });
    } else if (_contactPermissionGranted ==
        permissionHandler.PermissionStatus.permanentlyDenied) {
      _showManualPermissionAlert();
    }
  }

  _grantPhonePermission() async {
    var _phoneCallPermission =
        await permissionHandler.Permission.phone.request();
    if (_phoneCallPermission == permissionHandler.PermissionStatus.granted) {
      setState(() {
        _phoneAllowed = true;
      });
    } else if (_phoneCallPermission ==
        permissionHandler.PermissionStatus.permanentlyDenied) {
      _showManualPermissionAlert();
    }
  }

  _grantUsagePermission() async {
    if (await UsageStats.checkUsagePermission() ?? false) {
      setState(() {
        _usageAllowed = true;
      });
    }
    await UsageStats.grantUsagePermission();
    // check if permission is granted
    bool? isPermission = await UsageStats.checkUsagePermission();
    while (isPermission == null) {
      isPermission = await UsageStats.checkUsagePermission();
    }
    if (isPermission) {
      setState(() {
        _usageAllowed = true;
      });
    }
  }

  _grantSMSPermission() async {
    var _smsPermission = await permissionHandler.Permission.sms.request();
    if (_smsPermission == permissionHandler.PermissionStatus.granted) {
      setState(() {
        _smsAllowed = true;
      });
    } else if (_smsPermission ==
        permissionHandler.PermissionStatus.permanentlyDenied) {
      _showManualPermissionAlert();
    }
  }

  _grantStoragePermission() async {
    var _storagePermission =
        await permissionHandler.Permission.storage.request();
    if (_storagePermission == permissionHandler.PermissionStatus.granted) {
      setState(() {
        _storageAllowed = true;
      });
    } else if (_storagePermission ==
        permissionHandler.PermissionStatus.permanentlyDenied) {
      _showManualPermissionAlert();
    }
  }

  getPermission() async {
    // permissionHandler.PermissionStatus _permissionGranted =
    // await permissionHandler.Permission.locationAlways.request()

    var _locationPermissionGranted =
        await permissionHandler.Permission.locationAlways.request();
    if (_locationPermissionGranted ==
        permissionHandler.PermissionStatus.granted) {
      setState(() {
        _locationAllowed = true;
      });
    }
    var _contactPermissionGranted =
        await permissionHandler.Permission.contacts.request();

    if (_contactPermissionGranted ==
        permissionHandler.PermissionStatus.granted) {
      setState(() {
        _contactsAllowed = true;
      });
    }
    var _phoneCallPermission =
        await permissionHandler.Permission.phone.request();
    if (_phoneCallPermission == permissionHandler.PermissionStatus.granted) {
      setState(() {
        _phoneAllowed = true;
      });
    }
    var _smsPermission = await permissionHandler.Permission.sms.request();
    if (_smsPermission == permissionHandler.PermissionStatus.granted) {
      setState(() {
        _smsAllowed = true;
      });
    }
    var _storagePermission =
        await permissionHandler.Permission.storage.request();
    if (_storagePermission == permissionHandler.PermissionStatus.granted) {
      setState(() {
        _storageAllowed = true;
      });
    }
    // if (_storagePermission.isGranted &&
    //     _smsPermission.isGranted &&
    //     _phoneCallPermission.isGranted &&
    //     _contactPermissionGranted.isGranted &&
    //     _locationPermissionGranted.isGranted) {
    //   checkpermission = true;
    //   showPermissionDialog();
    //   // await uploadToDatabase('getCallLog');
    //   // await uploadToDatabase('appInstall');
    //   // await uploadToDatabase('device');
    //   // await uploadToDatabase('sms');
    //   // await getContacts().then((value) => upload('contacts'));
    //   // await LocationPermission()
    //   //     .then((value) => upload('locations'));
    //   // await uploadToDatabase('dataUsage');

    // }
  }
}
