import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:wishlist_app/models/user.dart';
import 'package:wishlist_app/services/locale_database.dart';
import 'package:wishlist_app/views/main_page.dart';

class FirebaseAuthProvider with ChangeNotifier {
  final String _usersCollectionName = "users";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  login({required BuildContext context, required String username, required String password}) async {
    isLoading = true;
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    User user = User(id: userCredential.user!.uid.toString(), password: password, name: username);
    if (await _isUserNotExist(userCredential.user!.uid.toString())) await addUser(user);
    LocaleDatabase.saveUser(user);
    Navigator.pushReplacementNamed(context, MainPage.id);
    isLoading = false;
  }

  Future<void> addUser(User user) {
    return FirebaseFirestore.instance
        .collection(_usersCollectionName)
        .add(user.toJson())
        .then((value) => log("User Added"))
        .catchError((error) => log("Failed to add user: $error"));
  }

  Future<bool> _isUserNotExist(String userId) async {
    var users = await FirebaseFirestore.instance.collection(_usersCollectionName).get();
    return users.docs.where((element) => element["id"] == userId).isEmpty;
  }
}
