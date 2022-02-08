import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._();

  FirebaseAuthService._();

  factory FirebaseAuthService() {
    return _instance;
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  login() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();
    log(userCredential.user!.uid.toString());
  }
}
