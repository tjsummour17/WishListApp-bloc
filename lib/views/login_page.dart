import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String id = "/Login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            TextFormField(controller: userNameController),
            TextFormField(controller: passwordController),
          ],
        ),
      ),
    );
  }
}
