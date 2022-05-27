import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ILevelService {
  Future<QuerySnapshot> getLevels();

  Future<DocumentSnapshot> getLevel(String id);
}

class LevelService extends ILevelService {
  late CollectionReference _notificationRef;

  LevelService() {
    _notificationRef = FirebaseFirestore.instance.collection("levels");
  }

  @override
  Future<QuerySnapshot<Object?>> getLevels() async {
    return await _notificationRef.get();
  }

  @override
  Future<DocumentSnapshot<Object?>> getLevel(String id) async {
    return await _notificationRef.doc(id).get();
  }
}
