import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:wishlist_app/models/user.dart';

class LocaleDatabase {
  static const String _userKey = 'lastUserLoggedIn';
  static late Box<User> userBox;

  LocaleDatabase._();

  static Future<void> initializeDB() async {
    try {
      await Hive.initFlutter();
      userBox = await Hive.openBox<User>('user');
    } catch (e) {
      log(e.toString());
    }
  }

  static void saveUser(User user) {
    try {
      userBox.put(_userKey, user);
    } catch (e) {
      log("@@@@@" + e.toString());
    }
  }

  static User? getUser() {
    try {
      return userBox.get(_userKey);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
