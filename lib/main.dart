import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wishlist_app/lang/lang.dart';
import 'package:wishlist_app/models/user.dart';
import 'package:wishlist_app/services/locale_database.dart';
import 'package:wishlist_app/views/login_page.dart';
import 'package:wishlist_app/views/main_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await LocaleDatabase.initializeDB();
    Firebase.initializeApp();
  } catch (e) {
    log(e.toString());
  }
  runApp(MyApp(user: LocaleDatabase.getUser()));
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wish List App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.all(7.5),

          )),
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
      supportedLocales: Lang.all,
      onGenerateRoute: (route) {
        switch (route.name) {
          case MainPage.id:
            return user == null ? MaterialPageRoute(builder: (context) => LoginPage()) : MaterialPageRoute(builder: (context) => MainPage());
          case LoginPage.id:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
        // LoginPage.id: (context) => const LoginPage(),
        // MainPage.id: (context) => const MainPage(),
        // log(user.toString());
        // if (user != null)
        //   return MaterialPageRoute(builder: (context) => MainPage());
        // else
        //   return MaterialPageRoute(builder: (context) => LoginPage());
      },
    );
  }
}
