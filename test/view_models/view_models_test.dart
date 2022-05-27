import 'package:flutter_application_1/configs/firebase_helper.dart';
import 'package:flutter_application_1/models/background_info_model.dart';
import 'package:flutter_application_1/models/bank_detail_model.dart';
import 'package:flutter_application_1/models/loan_request_model.dart';
import 'package:flutter_application_1/models/mtn_detail.dart';
import 'package:flutter_application_1/models/payment_info_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/repositories/loan_request_repo.dart';
import 'package:flutter_application_1/repositories/notification_repo.dart';
import 'package:flutter_application_1/repositories/user_repo.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';
import 'package:flutter_application_1/view_models/loan_request_view_model.dart';
import 'package:flutter_application_1/view_models/notifications_view_model.dart';
import 'package:flutter_application_1/view_models/payment_methods_view_model.dart';
import 'package:flutter_application_1/view_models/splash_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'view_models_test.mocks.dart';

@GenerateMocks([
  UserRepository,
  FirebaseHelper,
  LoanRequestRepository,
  NotificationRepository
])
void main() {
  var firebaseHelper = MockFirebaseHelper();
  when(firebaseHelper.getUserId()).thenReturn("");
  var loanReqRepo = MockLoanRequestRepository();
  var userRepo = MockUserRepository();
  var notifRepo = MockNotificationRepository();

  group('Testing apply view model tests', () {
    var bgInfoMock = BackgroundInformation.mock();
    when(userRepo.addBackgroundInfo(bgInfoMock, ""))
        .thenAnswer((_) async => true);
    var applyVm = ApplyViewModel(userRepo, firebaseHelper);

    test("Add background information with empty model", () async {
      var bgInfo = BackgroundInformation();
      when(userRepo.addBackgroundInfo(bgInfo, ""))
          .thenAnswer((_) async => false);
      applyVm.backgroundInformation = bgInfo;
      expect(await applyVm.addBackgroundInfo(), false);
    });
    test("Add background information", () async {
      applyVm.backgroundInformation = bgInfoMock;
      expect(await applyVm.addBackgroundInfo(), true);
    });
  });

  group("Test loan request view model tests", () {
    var loanReqMock = LoanRequest.mock();
    var loanReqVm = LoanRequestViewModel(loanReqRepo, firebaseHelper);
    when(loanReqRepo.createLoanRequest(loanReqMock))
        .thenAnswer((_) async => true);
    test("Create loan request positive", () async {
      expect(await loanReqVm.requestLoan(loanReqMock), true);
    });

    test("Create loan request invalid input", () async {
      expect(
          await loanReqVm
              .requestLoan(LoanRequest.fromMap(Map<String, dynamic>())),
          false);
    });
  });

  group("Notification view model tests", () {
    var notifVm = NotificationViewModel(notifRepo, firebaseHelper);

    test("Access notification before getting returns null", () {
      expect(notifVm.notifications, null);
    });

    test("Access notification after getting returns result", () async {
      when(notifRepo.getNotifications("")).thenAnswer((_) async => []);
      await notifVm.getNotifications();
      expect(notifVm.notifications, []);
    });
  });

  group("Payment method view model tests", () {
    test("Update payment info with empty payment info returns false", () async {
      var paymentInfo = PaymentInfo();
      when(userRepo.addPaymentInfo(paymentInfo, ""))
          .thenAnswer((_) async => false);
      var paymentMethodVm = PaymentMethodViewModel(userRepo, firebaseHelper);
      expect(await paymentMethodVm.updatePaymentInfo(paymentInfo), false);
    });

    test("Update payment info with proper mtn detail info returns true",
        () async {
      var paymentInfo = PaymentInfo(
          mtnDetail: MtnDetail(accountNumber: "123", fullName: "John Doe"));
      when(userRepo.addPaymentInfo(paymentInfo, ""))
          .thenAnswer((_) async => true);
      var paymentMethodVm = PaymentMethodViewModel(userRepo, firebaseHelper);
      expect(await paymentMethodVm.updatePaymentInfo(paymentInfo), true);
    });

    test("Update payment info with proper payment info returns true", () async {
      var paymentInfo = PaymentInfo(
          bankDetail: BankDetail(
              accountNumber: "1234",
              accountType: "personal",
              bankCode: "1234",
              bankName: "test bank",
              hodlerName: "John Doe"));
      when(userRepo.addPaymentInfo(paymentInfo, ""))
          .thenAnswer((_) async => true);
      var paymentMethodVm = PaymentMethodViewModel(userRepo, firebaseHelper);
      expect(await paymentMethodVm.updatePaymentInfo(paymentInfo), true);
    });
  });

  group("Splash ViewvModel test", () {
    var splashVm = SplashViewModel(userRepo, firebaseHelper);
    test("Get user with non existing id should return null", () async {
      when(userRepo.getUser("")).thenAnswer((_) async => null);
      expect(await splashVm.getUser(), null);
    });

    test("Get user with a valid id should return that user", () async {
      when(userRepo.getUser("123")).thenAnswer((_) async => User(
          firstName: "firstName",
          lastName: "lastName",
          id: "123",
          address: "address",
          mobileNumber: "mobileNumber",
          dob: "dob",
          fcmToken: "fcmToken"));
      when(firebaseHelper.getUserId()).thenReturn("123");
      await splashVm.getUser();
      expect((splashVm.user as User).id, "123");
    });
  });
}
