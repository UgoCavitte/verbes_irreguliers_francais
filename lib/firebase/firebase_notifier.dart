import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebase_options.dart';

enum FirebaseState { loading, available, notAvailable }

class FirebaseNotifier extends ChangeNotifier {
  bool loggedIn = false;
  FirebaseState state = FirebaseState.loading;
  bool isLoggingIn = false;

  FirebaseNotifier() {
    load();
  }

  late final Completer<bool> _isInitialized = Completer();

  Future<FirebaseFirestore> get firestore async {
    var isInitialized = await _isInitialized.future;
    if (!isInitialized) {
      throw Exception('Firebase is not initialized');
    }
    return FirebaseFirestore.instance;
  }

  User? get userFB => FirebaseAuth.instance.currentUser;

  Future<void> load() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      loggedIn = FirebaseAuth.instance.currentUser != null;
      state = FirebaseState.available;
      _isInitialized.complete(true);
      notifyListeners();
    } catch (e) {
      state = FirebaseState.notAvailable;
      _isInitialized.complete(false);
      notifyListeners();
    }
  }

  Future<void> login(void Function() reload) async {
    isLoggingIn = true;
    notifyListeners();
    // Trigger the authentication flow
    try {

      await GoogleSignIn.instance.initialize();

      final googleUser = await GoogleSignIn.instance.authenticate();

      // Obtain the auth details from the request
      final googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        // accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      // await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

      loggedIn = true;
      isLoggingIn = false;
      reload();
      notifyListeners();
    } catch (e) {

      print("[app] -> $e");

      isLoggingIn = false;
      notifyListeners();
      return;
    }
  }
}
