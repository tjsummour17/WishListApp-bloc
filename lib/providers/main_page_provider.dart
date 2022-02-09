import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wishlist_app/services/wishlist_service.dart';
import 'package:wishlist_app/views/settings_view.dart';
import 'package:wishlist_app/views/wishlist_view.dart';

class MainPageProvider with ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  List<Widget> mainPageViews = [const WishlistView(), const SettingsView()];

  List<BottomNavigationBarItem> bottomNavBarItems(BuildContext context) => [
        BottomNavigationBarItem(icon: const Icon(Icons.home_rounded), label: AppLocalizations.of(context)!.home),
        BottomNavigationBarItem(icon: const Icon(Icons.settings), label: AppLocalizations.of(context)!.settings),
      ];

  void setPageIndex(int value) {
    pageIndex = value;
  }
}
