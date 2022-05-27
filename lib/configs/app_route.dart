import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/models/bank_detail_model.dart';
import 'package:flutter_application_1/models/loan_request_model.dart';
import 'package:flutter_application_1/pages/apply/apply_final_step.dart';
import 'package:flutter_application_1/pages/apply/first_time/apply_splash.dart';
import 'package:flutter_application_1/pages/apply/first_time/for_rest/for_rest1.dart';
import 'package:flutter_application_1/pages/apply/first_time/for_rest/for_rest2.dart';
import 'package:flutter_application_1/pages/apply/first_time/for_rest/for_rest3.dart';
import 'package:flutter_application_1/pages/apply/first_time/for_rest/for_rest4.dart';
import 'package:flutter_application_1/pages/apply/first_time/for_sme/for_sme1.dart';
import 'package:flutter_application_1/pages/apply/first_time/for_sme/for_sme2.dart';
import 'package:flutter_application_1/pages/apply/first_time/for_sme/for_sme3.dart';
import 'package:flutter_application_1/pages/apply/first_time/for_sme/for_sme4.dart';
import 'package:flutter_application_1/pages/apply/recurring/loan_application_info.dart';
import 'package:flutter_application_1/pages/main_views/account_method.dart';
import 'package:flutter_application_1/pages/main_views/bank_account_method.dart';
import 'package:flutter_application_1/pages/main_views/home_with_bottom_navbar.dart';
import 'package:flutter_application_1/pages/main_views/permissions_page.dart';
import 'package:flutter_application_1/pages/verification/bank_statement_reupload.dart';
import 'package:flutter_application_1/pages/verification/id_reupload.dart';
import 'package:flutter_application_1/pages/verification/pending_verification.dart';
import 'package:flutter_application_1/pages/verification/proof_of_address_reupload.dart';
import 'package:flutter_application_1/pages/verification/verification_reupload.dart';
import 'package:flutter_application_1/pages/otp_ver_page.dart';
import 'package:flutter_application_1/pages/phone_input_page.dart';
import 'package:flutter_application_1/pages/registration/get_started.dart';
import 'package:flutter_application_1/pages/registration/verification.dart';
import 'package:flutter_application_1/pages/registration/verification2.dart';
import 'package:flutter_application_1/pages/registration/verification3.dart';
import 'package:flutter_application_1/pages/registration/verification4.dart';
import 'package:flutter_application_1/pages/splash_page.dart';
import 'package:flutter_application_1/utils/auth_helper.dart';

class AppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GetStartedPage.pageName:
        return _materialPageRoute(GetStartedPage(), settings);
      case SplashPage.pageName:
        return _materialPageRoute(SplashPage(), settings);
      case HomeWithBottomNavBar.pageName:
        return _materialPageRoute(HomeWithBottomNavBar(), settings);
      case LoginScreen.pageName:
        return _materialPageRoute(LoginScreen(), settings);
      case PhoneInputPage.pageName:
        return _materialPageRoute(PhoneInputPage(), settings);
      case OTPVerificationPage.pageName:
        return _materialPageRoute(OTPVerificationPage(), settings);
      case VerificationPage.pageName:
        return _materialPageRoute(VerificationPage(), settings);
      case VerificationPage2.pageName:
        return _materialPageRoute(VerificationPage2(), settings);
      case VerificationPage3.pageName:
        return _materialPageRoute(VerificationPage3(), settings);
      case VerificationPage4.pageName:
        return _materialPageRoute(VerificationPage4(), settings);
      case ApplySplash.pageName:
        return _materialPageRoute(ApplySplash(), settings);
      case ApplyFinalStep.pageName:
        LoanRequest loanRequest = settings.arguments as LoanRequest;
        return _materialPageRoute(ApplyFinalStep(loanRequest), settings);
      case ApplyForSME1.pageName:
        return _materialPageRoute(ApplyForSME1(), settings);
      case ApplyForSME2.pageName:
        return _materialPageRoute(ApplyForSME2(), settings);
      case ApplyForSME3.pageName:
        return _materialPageRoute(ApplyForSME3(), settings);
      case ApplyForSME4.pageName:
        return _materialPageRoute(ApplyForSME4(), settings);
      case ApplyForRest1.pageName:
        return _materialPageRoute(ApplyForRest1(), settings);
      case ApplyForRest2.pageName:
        return _materialPageRoute(ApplyForRest2(), settings);
      case ApplyForRest3.pageName:
        return _materialPageRoute(ApplyForRest3(), settings);
      case ApplyForRest4.pageName:
        return _materialPageRoute(ApplyForRest4(), settings);
      case AccountMethod.pageName:
        return _materialPageRoute(AccountMethod(), settings);
      case PendingVerificationPage.pageName:
        return _materialPageRoute(PendingVerificationPage(), settings);
      case VerificationReuploadPage.pageName:
        return _materialPageRoute(VerificationReuploadPage(), settings);
      case ReuploadIDPage.pageName:
        return _materialPageRoute(ReuploadIDPage(), settings);
      case ReuploadBankStatementPage.pageName:
        return _materialPageRoute(ReuploadBankStatementPage(), settings);
      case ReuploadProofOfAddressPage.pageName:
        return _materialPageRoute(ReuploadProofOfAddressPage(), settings);
      case PermissionsPage.pageName:
        return _materialPageRoute(PermissionsPage(), settings);
      case UpdateBankAccountScreen.pageName:
        BankDetail bankDetail = settings.arguments as BankDetail;
        return _materialPageRoute(
            UpdateBankAccountScreen(bankDetail), settings);
      case LoanApplicationInfoPage.pageName:
        var firstTime = settings.arguments ?? false;
        return _materialPageRoute(
            LoanApplicationInfoPage(
              firstTime: firstTime as bool,
            ),
            settings);
      default:
        if (AuthHelper.isLoggedIn())
          return _materialPageRoute(SplashPage(), settings);
        return _materialPageRoute(PhoneInputPage(), settings);
    }
  }

  static _materialPageRoute(Widget screen, settings) {
    return MaterialPageRoute(builder: (context) => screen, settings: settings);
  }
}
