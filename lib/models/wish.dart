import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Wish {
  String docId;
  final String userId;
  final String title;
  final String? description;
  String imageRef;
  late DateTime dateCreated;

  Wish({this.docId = "", required this.userId, required this.title, this.description, this.imageRef = ""}) {
    dateCreated = DateTime.now();
  }

  Map<String, dynamic> toJson() => {'userId': userId, 'title': title, 'description': description, 'imageRef': imageRef, "dateCreated": dateCreated};

  factory Wish.fromJson(Map<String, dynamic> json) {
    Wish wish = Wish(userId: json["userId"], title: json["title"], description: json["description"], imageRef: json["imageRef"]);
    wish.dateCreated = DateTime.fromMillisecondsSinceEpoch((json["dateCreated"] as Timestamp).millisecondsSinceEpoch);
    return wish;
  }
}
