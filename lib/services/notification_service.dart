import 'package:cloud_firestore/cloud_firestore.dart';

abstract class INotificationService {
  Future<QuerySnapshot> getNotifications(String uid);
}

class NotificationService extends INotificationService {
  late CollectionReference _notificationRef;
  NotificationService() {
    _notificationRef = FirebaseFirestore.instance.collection("notifications");
  }

  @override
  Future<QuerySnapshot<Object?>> getNotifications(String uid) async {
    return await _notificationRef.where("userId", isEqualTo: uid).get();
  }
}
