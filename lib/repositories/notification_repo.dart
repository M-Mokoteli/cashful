import 'package:flutter_application_1/models/notification_model.dart';
import 'package:flutter_application_1/services/notification_service.dart';

class NotificationRepository {
  NotificationService _notificationService;
  NotificationRepository(this._notificationService);

  Future<List<Notification>?> getNotifications(String uid) async {
    var snapshot = await _notificationService.getNotifications(uid);
    List<Notification> notifications = [];
    notifications.addAll(snapshot.docs.map((e) => Notification.fromFirebase(e)).toList());
    return notifications;
  }
}
