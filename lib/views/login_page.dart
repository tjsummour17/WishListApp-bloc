import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_app/res/assets.dart';
import 'package:wishlist_app/providers/firebase_auth_provider.dart';
import 'package:wishlist_app/views/widgets/default_themes.dart';

class LoginPage extends StatelessWidget {
  static const String id = "/Login";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuthProvider firebaseAuthProvider = Provider.of<FirebaseAuthProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ListView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: DefaultThemes.defaultContainerTheme(context),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SvgPicture.asset(Assets.appIcon, width: 75, height: 75),
                        const SizedBox(height: 10),
                        Text(AppLocalizations.of(context)!.appName, style: Theme.of(context).textTheme.headline6),
                        const SizedBox(height: 40),
                        TextFormField(
                            decoration: InputDecoration(hintText: AppLocalizations.of(context)!.username),
                            controller: userNameController,
                            validator: (text) => text!.length < 3 ? AppLocalizations.of(context)!.usernameError : null),
                        const SizedBox(height: 20),
                        TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(hintText: AppLocalizations.of(context)!.password),
                            validator: (text) => text!.length < 4 ? AppLocalizations.of(context)!.passwordError : null),
                        const SizedBox(height: 20),
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 80,
                            child: ElevatedButton(
                                onPressed: () => login(context),
                                child: Text(AppLocalizations.of(context)!.login, style: Theme.of(context).textTheme.button)))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (firebaseAuthProvider.isLoading) Container(color: Theme.of(context).shadowColor, child: const Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Provider.of<FirebaseAuthProvider>(context, listen: false)
          .login(context: context, username: userNameController.text, password: passwordController.text);
    }
  }
}
