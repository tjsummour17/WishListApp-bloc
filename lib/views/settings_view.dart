import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_app/lang/lang.dart';
import 'package:wishlist_app/providers/locale_provider.dart';
import 'package:wishlist_app/providers/main_page_provider.dart';
import 'package:wishlist_app/providers/theme_provider.dart';
import 'package:wishlist_app/providers/user_provider.dart';
import 'package:wishlist_app/views/login_page.dart';
import 'package:wishlist_app/views/widgets/default_themes.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  _logout() {
    Provider.of<UserProvider>(context, listen: false).logout();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, LoginPage.id);
    Provider.of<MainPageProvider>(context, listen: false).pageIndex = 0;
  }

  _buildLogoutDialog() async {
    await showDialog(
        builder: (BuildContext context) => (Platform.isIOS)
            ? CupertinoAlertDialog(
                title: Text(AppLocalizations.of(context)!.logout),
                content: Text(AppLocalizations.of(context)!.logoutDescription),
                actions: [
                    TextButton(onPressed: _logout, child: Text(AppLocalizations.of(context)!.yes)),
                    TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.no))
                  ])
            : AlertDialog(title: Text(AppLocalizations.of(context)!.logout), content: Text(AppLocalizations.of(context)!.logoutDescription), actions: [
                TextButton(onPressed: _logout, child: Text(AppLocalizations.of(context)!.yes)),
                TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.no))
              ]),
        context: context);
  }

  Widget _buildSettingsButton({required String text, required VoidCallback? onPressed, Widget? icon, Widget? leading, bool hasDivider = true}) {
    final buttonStyle = ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey[200]),
        elevation: MaterialStateProperty.resolveWith((states) => 0),
        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).colorScheme.surface));
    return Column(
      children: [
        ElevatedButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: Row(children: <Widget>[
              SizedBox(width: 50, height: 50, child: icon),
              Container(width: 0.5, height: 50, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(child: Text(text, style: Theme.of(context).textTheme.subtitle2)),
              if (leading != null) leading,
              const SizedBox(width: 10)
            ])),
        if (hasDivider) const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final locale = localeProvider.locale;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: DefaultThemes.defaultContainerTheme(context),
            child: Column(
              children: [
                _buildSettingsButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), color: Theme.of(context).colorScheme.surface),
                              child: SafeArea(
                                child: Column(mainAxisSize: MainAxisSize.min, children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CloseButton(),
                                      Container(
                                          margin: const EdgeInsets.all(10),
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.onSurface),
                                          width: 100,
                                          height: 10),
                                      const SizedBox(width: 50)
                                    ],
                                  ),
                                  Text(AppLocalizations.of(context)!.language, style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  RadioListTile(
                                      value: 'en',
                                      groupValue: locale.languageCode,
                                      onChanged: (String? languageCode) {
                                        localeProvider.locale = Locale(languageCode!);
                                        Navigator.pop(context);
                                      },
                                      title: Text(Lang.getLangName('en'))),
                                  RadioListTile(
                                      value: 'ar',
                                      groupValue: locale.languageCode,
                                      onChanged: (String? languageCode) {
                                        localeProvider.locale = Locale(languageCode!);
                                        Navigator.pop(context);
                                      },
                                      title: Text(Lang.getLangName('ar'))),
                                ]),
                              ),
                            ));
                  },
                  icon: Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
                  text: AppLocalizations.of(context)!.language,
                  leading: Text(Lang.getLangName(locale.languageCode), style: Theme.of(context).textTheme.subtitle2),
                ),
                _buildSettingsButton(
                  icon: Icon(Icons.brightness_4_rounded, color: Theme.of(context).colorScheme.primary),
                  text: AppLocalizations.of(context)!.theme,
                  leading: Text(
                    (themeProvider.themeMode == ThemeMode.system)
                        ? AppLocalizations.of(context)!.systemDefault
                        : (themeProvider.themeMode == ThemeMode.dark)
                            ? AppLocalizations.of(context)!.dark
                            : AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        builder: (context) => Container(
                              child: SafeArea(
                                child: Column(mainAxisSize: MainAxisSize.min, children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CloseButton(),
                                      Container(
                                          margin: const EdgeInsets.all(10),
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.onSurface),
                                          width: 100,
                                          height: 10),
                                      const SizedBox(width: 50)
                                    ],
                                  ),
                                  Text(AppLocalizations.of(context)!.theme, style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  RadioListTile<ThemeMode>(
                                      value: ThemeMode.system,
                                      groupValue: themeProvider.themeMode,
                                      onChanged: (ThemeMode? theme) => themeProvider.themeMode = theme!,
                                      title: Text(AppLocalizations.of(context)!.systemDefault)),
                                  RadioListTile(
                                      value: ThemeMode.light,
                                      groupValue: themeProvider.themeMode,
                                      onChanged: (ThemeMode? theme) => themeProvider.themeMode = theme!,
                                      title: Text(AppLocalizations.of(context)!.light)),
                                  RadioListTile(
                                      value: ThemeMode.dark,
                                      groupValue: themeProvider.themeMode,
                                      onChanged: (ThemeMode? theme) => themeProvider.themeMode = theme!,
                                      title: Text(AppLocalizations.of(context)!.dark)),
                                ]),
                              ),
                            ));
                  },
                ),
                _buildSettingsButton(
                    icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.primary),
                    text: AppLocalizations.of(context)!.logout,
                    hasDivider: false,
                    onPressed: _buildLogoutDialog),
              ],
            ),
          )
        ],
      ),
    );
  }
}
