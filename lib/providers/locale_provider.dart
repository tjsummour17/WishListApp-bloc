import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wishlist_app/lang/lang.dart';
import 'package:wishlist_app/services/locale_database.dart';

class LocaleProvider with ChangeNotifier {
  Locale get locale => Locale(LocaleDatabase.getLanguage());

  bool isConnectedToInternet = true;

  set locale(Locale locale) {
    if (!Lang.all.contains(locale)) return;
    LocaleDatabase.saveLanguage(locale.languageCode);
    notifyListeners();
  }

  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnectedToInternet = true;
      } else {
        isConnectedToInternet = false;
      }
    } catch (_) {
      isConnectedToInternet = false;
    }
    notifyListeners();
  }
}
