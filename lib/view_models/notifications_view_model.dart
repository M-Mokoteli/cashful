import 'package:flutter_application_1/configs/firebase_helper.dart';
import 'package:flutter_application_1/models/notification_model.dart';
import 'package:flutter_application_1/repositories/notification_repo.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';

class NotificationViewModel extends BaseViewModel {
  NotificationRepository _notificationRepository;
  FirebaseHelper _firebaseHelper;
  NotificationViewModel(this._notificationRepository, this._firebaseHelper);
  List<Notification>? _notifications;

  get notifications => _notifications;
  Future<bool> getNotifications() async {
    try {
      setState(ViewState.Busy);
      var result = await _notificationRepository
          .getNotifications(_firebaseHelper.getUserId()!);
      _notifications = result;
      setState(ViewState.Idle);
      return true;
    } catch (e, stk) {
      print(e);
      print(stk);
      setState(ViewState.Idle);
      return false;
    }
  }
}
