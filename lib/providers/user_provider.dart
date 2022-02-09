import 'package:flutter/material.dart';
import 'package:wishlist_app/models/user.dart';
import 'package:wishlist_app/services/locale_database.dart';

class UserProvider with ChangeNotifier {
  User? get user => LocaleDatabase.getUser();

  set user(User? user) {
    if (user != null) LocaleDatabase.saveUser(user);
    notifyListeners();
  }

  void logout() {
    LocaleDatabase.deleteLastLoggedInUser();
    user = null;
    notifyListeners();
  }
}
