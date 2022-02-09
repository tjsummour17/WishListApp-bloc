import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_app/providers/main_page_provider.dart';
import 'package:wishlist_app/providers/user_provider.dart';
import 'package:wishlist_app/services/locale_database.dart';
import 'package:wishlist_app/services/wishlist_service.dart';
import 'package:wishlist_app/views/settings_view.dart';

import '../providers/firebase_auth_provider.dart';

class MainPage extends StatefulWidget {
  static const String id = "/";

  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    MainPageProvider mainPageProvider = Provider.of<MainPageProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(mainPageProvider.bottomNavBarItems(context)[mainPageProvider.pageIndex].label ?? "")),
      body: mainPageProvider.mainPageViews[mainPageProvider.pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: mainPageProvider.pageIndex,
        items: mainPageProvider.bottomNavBarItems(context),
        onTap: mainPageProvider.setPageIndex,
      ),
    );
  }
}
