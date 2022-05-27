import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/configs/firebase_helper.dart';
import 'package:flutter_application_1/repositories/level_repo.dart';
import 'package:flutter_application_1/repositories/loan_request_repo.dart';
import 'package:flutter_application_1/repositories/notification_repo.dart';
import 'package:flutter_application_1/repositories/user_repo.dart';
import 'package:flutter_application_1/services/level_service.dart';
import 'package:flutter_application_1/services/loan_request_service.dart';
import 'package:flutter_application_1/services/notification_service.dart';
import 'package:flutter_application_1/services/payment_service.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_application_1/view_models/apply_view_model.dart';
import 'package:flutter_application_1/view_models/auth_view_model.dart';
import 'package:flutter_application_1/view_models/level_view_model.dart';
import 'package:flutter_application_1/view_models/loan_request_view_model.dart';
import 'package:flutter_application_1/view_models/notifications_view_model.dart';
import 'package:flutter_application_1/view_models/payment_methods_view_model.dart';
import 'package:flutter_application_1/view_models/registration/get_started_view_model.dart';
import 'package:flutter_application_1/view_models/splash_view_model.dart';
import 'package:flutter_application_1/view_models/status_view_model.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/view_models/verification_view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // register classes
  locator.registerLazySingleton<FirebaseHelper>(() => FirebaseHelper());
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // register services
  locator.registerLazySingleton<UserService>(
      () => UserService(locator.get<FirebaseFirestore>()));
  locator.registerLazySingleton<PaymentService>(() => PaymentService());
  locator.registerLazySingleton<LoanRequestService>(() => LoanRequestService());
  locator
      .registerLazySingleton<NotificationService>(() => NotificationService());
  locator.registerLazySingleton<LevelService>(() => LevelService());

  // register repositories
  locator.registerLazySingleton<UserRepository>(() => UserRepository(
      locator.get<UserService>(), locator.get<PaymentService>()));
  locator.registerLazySingleton<LoanRequestRepository>(
      () => LoanRequestRepository(locator.get<LoanRequestService>()));
  locator.registerLazySingleton<NotificationRepository>(
      () => NotificationRepository(locator.get<NotificationService>()));
  locator.registerLazySingleton<LevelRepository>(
      () => LevelRepository(locator.get<LevelService>()));

  // register view models
  locator.registerLazySingleton<AuthViewModel>(() => AuthViewModel());
  locator.registerLazySingleton<GetStartedViewModel>(
      () => GetStartedViewModel(locator.get<UserRepository>()));
  locator.registerLazySingleton<LoanRequestViewModel>(() =>
      LoanRequestViewModel(
          locator.get<LoanRequestRepository>(), locator.get<FirebaseHelper>()));
  locator.registerLazySingleton<SplashViewModel>(() => SplashViewModel(
      locator.get<UserRepository>(), locator.get<FirebaseHelper>()));

  locator.registerLazySingleton<VerificationViewModel>(() =>
      VerificationViewModel(
          locator.get<UserRepository>(), locator.get<FirebaseHelper>()));

  locator.registerLazySingleton<ApplyViewModel>(() => ApplyViewModel(
      locator.get<UserRepository>(), locator.get<FirebaseHelper>()));
  locator.registerLazySingleton<UserViewModel>(
      () => UserViewModel(locator.get<FirebaseFirestore>()));
  locator.registerLazySingleton<PaymentMethodViewModel>(() =>
      PaymentMethodViewModel(
          locator.get<UserRepository>(), locator.get<FirebaseHelper>()));
  locator.registerLazySingleton<StatusViewModel>(() => StatusViewModel(
      locator.get<LoanRequestRepository>(), locator.get<FirebaseHelper>()));
  locator.registerLazySingleton<NotificationViewModel>(() =>
      NotificationViewModel(locator.get<NotificationRepository>(),
          locator.get<FirebaseHelper>()));
  locator.registerLazySingleton<LevelViewModel>(
      () => LevelViewModel(locator.get<LevelRepository>()));

  //Download levels for future use
  locator.get<LevelViewModel>().getLevels();
}
