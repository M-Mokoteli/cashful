import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  late String? id;
  late String title;
  late String body;
  late int? createdAt;
  Notification({
    this.id,
    required this.title,
    required this.body,
    this.createdAt,
  });

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id;
    return Notification.fromMap(data);
  }
}
