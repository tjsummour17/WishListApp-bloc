import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wishlist_app/models/user.dart';
import 'package:wishlist_app/res/constants.dart';

class LocaleDatabase {
  static const String _userKey = 'lastUserLoggedIn';
  static const String _themeKey = 'theme';
  static const String _languageKey = 'language';
  static late Box<User> userBox;
  static late Box<String> themeBox;
  static late Box<String> languageBox;

  LocaleDatabase._();

  static Future<void> initializeDB() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(UserAdapter());
      userBox = await Hive.openBox<User>('user');
      themeBox = await Hive.openBox<String>('theme');
      languageBox = await Hive.openBox<String>('language');
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

  static deleteLastLoggedInUser() {
    try {
      userBox.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  static void saveTheme(String themeMode) {
    try {
      themeBox.put(_themeKey, themeMode);
    } catch (e) {
      log("@@@@@" + e.toString());
    }
  }

  static ThemeMode getTheme() {
    try {
      String? theme = themeBox.get(_themeKey);
      return theme == Constants.darkTheme
          ? ThemeMode.dark
          : theme == Constants.lightTheme
              ? ThemeMode.light
              : ThemeMode.system;
    } catch (e) {
      log(e.toString());
      return ThemeMode.system;
    }
  }

  static void saveLanguage(String lang) {
    try {
      languageBox.put(_languageKey, lang);
    } catch (e) {
      log("@@@@@" + e.toString());
    }
  }

  static String getLanguage() {
    try {
      return languageBox.get(_languageKey) ?? "en";
    } catch (e) {
      log(e.toString());
      return "en";
    }
  }
}
