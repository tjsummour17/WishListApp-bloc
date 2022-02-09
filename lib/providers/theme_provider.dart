import 'package:flutter/material.dart';
import 'package:wishlist_app/res/constants.dart';
import 'package:wishlist_app/services/locale_database.dart';

class ThemeProvider with ChangeNotifier {

  ThemeMode get themeMode => LocaleDatabase.getTheme();

  set themeMode(ThemeMode value) {
    LocaleDatabase.saveTheme(value == ThemeMode.dark
        ? Constants.darkTheme
        : value == ThemeMode.light
            ? Constants.lightTheme
            : Constants.systemTheme);
    notifyListeners();
  }
}
