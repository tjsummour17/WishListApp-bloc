import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_app/lang/lang.dart';
import 'package:wishlist_app/providers/firebase_auth_provider.dart';
import 'package:wishlist_app/providers/locale_provider.dart';
import 'package:wishlist_app/providers/main_page_provider.dart';
import 'package:wishlist_app/providers/theme_provider.dart';
import 'package:wishlist_app/providers/user_provider.dart';
import 'package:wishlist_app/services/locale_database.dart';
import 'package:wishlist_app/utils/app_bloc_observer.dart';
import 'package:wishlist_app/views/login_page.dart';
import 'package:wishlist_app/views/main_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wishlist_app/views/new_wish_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await LocaleDatabase.initializeDB();
    Firebase.initializeApp();
  } catch (e) {
    log(e.toString());
  }
  BlocOverrides.runZoned(() => runApp(const MyApp()), blocObserver: AppBlocObserver());
}

class MyApp extends StatelessWidget {
  final Color primaryLightColor = const Color(0xFFFC66B3);
  final Color backgroundLightColor = const Color(0xFFF5F5F5);
  final Color primaryDarkColor = Colors.purple;
  final Color backgroundDarkColor = const Color(0xFF303030);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => LocaleProvider()),
          ChangeNotifierProvider(create: (context) => FirebaseAuthProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => MainPageProvider()),
        ],
        builder: (BuildContext context, Widget? child) {
          ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
          LocaleProvider localeProvider = Provider.of<LocaleProvider>(context);
          UserProvider userProvider = Provider.of<UserProvider>(context);
          return MaterialApp(
            title: 'Wish List App',
            themeMode: themeProvider.themeMode,
            locale: localeProvider.locale,
            theme: ThemeData(
                primarySwatch: Colors.pink,
                shadowColor: Colors.grey.withOpacity(0.50),
                scaffoldBackgroundColor: backgroundLightColor,
                colorScheme: ColorScheme.light(background: backgroundLightColor, primary: primaryLightColor, secondary: primaryLightColor),
                appBarTheme: AppBarTheme(
                    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryLightColor),
                    color: backgroundLightColor,
                    iconTheme: IconThemeData(color: primaryLightColor),
                    elevation: 0),
                textTheme: const TextTheme(button: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                inputDecorationTheme: const InputDecorationTheme(contentPadding: EdgeInsets.all(7.5), filled: true)),
            darkTheme: ThemeData(
                primarySwatch: Colors.purple,
                shadowColor: const Color(0x88505050),
                scaffoldBackgroundColor: backgroundDarkColor,
                colorScheme: ColorScheme.dark(background: backgroundDarkColor, primary: Colors.purple),
                appBarTheme: AppBarTheme(color: backgroundDarkColor, elevation: 0),
                textTheme: const TextTheme(button: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                inputDecorationTheme: const InputDecorationTheme(contentPadding: EdgeInsets.all(7.5), filled: true)),
            localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
            supportedLocales: Lang.all,
            onGenerateRoute: (route) {
              switch (route.name) {
                case MainPage.id:
                  return userProvider.user == null ? MaterialPageRoute(builder: (context) => LoginPage()) : MaterialPageRoute(builder: (context) => const MainPage());
                case LoginPage.id:
                  return MaterialPageRoute(builder: (context) => LoginPage());
                case NewWishForm.id:
                  return MaterialPageRoute(builder: (context) => const NewWishForm());
              }
            },
          );
        });
  }
}
