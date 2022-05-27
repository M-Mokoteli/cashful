import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/pages/apply/apply_steps_common.dart';
import 'package:flutter_application_1/pages/main_views/home_with_bottom_navbar.dart';
import 'package:flutter_application_1/widgets/text_h1.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import 'package:usage_stats/usage_stats.dart';

class PermissionsPage extends StatefulWidget {
  static const pageName = "permissions";

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
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
            Card(
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
                      title: "Storage permission",
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
                  ListTile(
                    title: TextH4(
                      title: "Usage access",
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
                  ListTile(
                    title: TextH4(
                      title: "Phone permission",
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
                  ListTile(
                    title: TextH4(
                      title: "SMS permission",
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
                  ListTile(
                    title: TextH4(
                      title: "Location permission",
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
                  ListTile(
                    title: TextH4(
                      title: "Contacts permission",
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                        "For more information, visit our privacy policy on our website"),
                  ),
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
                              Navigator.of(context).pushReplacementNamed(
                                  HomeWithBottomNavBar.pageName);
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
          ],
        ));
  }

  _grantLocationPermission() async {
    var _locationPermissionGranted =
        await permissionHandler.Permission.locationWhenInUse.request();
    if (_locationPermissionGranted ==
        permissionHandler.PermissionStatus.granted) {
      setState(() {
        _locationAllowed = true;
      });
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
    }
  }

  _grantPhonePermission() async {
    var _phoneCallPermission =
        await permissionHandler.Permission.phone.request();
    if (_phoneCallPermission == permissionHandler.PermissionStatus.granted) {
      setState(() {
        _phoneAllowed = true;
      });
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
    }
  }

  _grantStoragePermission() async {
    var _storagePermission =
        await permissionHandler.Permission.storage.request();
    if (_storagePermission == permissionHandler.PermissionStatus.granted) {
      setState(() {
        _storageAllowed = true;
      });
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
