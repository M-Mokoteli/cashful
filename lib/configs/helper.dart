import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/locator.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/pages/main_views/home_with_bottom_navbar.dart';
import 'package:flutter_application_1/pages/main_views/permissions_page.dart';
import 'package:flutter_application_1/pages/registration/get_started.dart';
import 'package:flutter_application_1/pages/registration/verification.dart';
import 'package:flutter_application_1/pages/registration/verification2.dart';
import 'package:flutter_application_1/pages/registration/verification3.dart';
import 'package:flutter_application_1/pages/registration/verification4.dart';
import 'package:flutter_application_1/pages/verification/pending_verification.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart' as permissionHandler;
import 'package:usage_stats/usage_stats.dart';

class AppHelper {
  static String? requiredValidator(value) {
    if (value == null || value == "") {
      return "Field required";
    }
    return null;
  }

  static void showSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static void setRecurringFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("first-time", true);
  }

  static Future<bool> permissionsAllowed() async {
    var _storageAllowed =
        await permissionHandler.Permission.storage.status == permissionHandler.PermissionStatus.granted;
    var _phoneAllowed = await permissionHandler.Permission.phone.status == permissionHandler.PermissionStatus.granted;
    var _smsAllowed = await permissionHandler.Permission.sms.status == permissionHandler.PermissionStatus.granted;
    var _locationAllowed =
        await permissionHandler.Permission.location.status == permissionHandler.PermissionStatus.granted;
    var _contactsAllowed =
        await permissionHandler.Permission.contacts.status == permissionHandler.PermissionStatus.granted;
    var _usageAllowed = await UsageStats.checkUsagePermission() ?? false;

    return _contactsAllowed && _locationAllowed && _phoneAllowed && _smsAllowed && _storageAllowed && _usageAllowed;
  }

  static void checkUserStatAndNavigate(context, User? user) {
    if (user == null) {
      // user is new user so register
      Navigator.pushReplacementNamed(context, GetStartedPage.pageName);
      return;
    }
    Provider.of<UserViewModel>(context, listen: false).setUser(user);
    log(user.toMap().toString());
    if (user.verificationDocuments != null) {
      if (user.verificationDocuments!.idCard == null) {
        Navigator.pushReplacementNamed(context, VerificationPage.pageName);
      } else if (user.verificationDocuments!.bankStatement == null) {
        Navigator.pushReplacementNamed(context, VerificationPage2.pageName);
      } else if (user.verificationDocuments!.proofOfAddress == null) {
        Navigator.pushReplacementNamed(context, VerificationPage3.pageName);
      } else if (user.bankDetail == null && user.mtnDetail == null) {
        Navigator.pushReplacementNamed(context, VerificationPage4.pageName);
      } else {
        locator<UserViewModel>().setUser(user);
        // check if user is verified
        // print(user.verificationDocuments!.toMap());
        var status = user.verificationDocuments!.bankStatement!['status'] != 'approved' ||
            user.verificationDocuments!.idCard!['status'] != 'approved' ||
            user.verificationDocuments!.proofOfAddress!['status'] != 'approved';

        print("Status $status");
        if (status) {
          Navigator.pushReplacementNamed(context, PendingVerificationPage.pageName);
        } else {
          AppHelper.permissionsAllowed().then((value) {
            if (!value)
              Navigator.pushNamed(context, PermissionsPage.pageName);
            else
              Navigator.pushReplacementNamed(context, HomeWithBottomNavBar.pageName);
          });
        }
      }
    } else {
      Navigator.pushReplacementNamed(context, VerificationPage.pageName);
    }
  }
}
