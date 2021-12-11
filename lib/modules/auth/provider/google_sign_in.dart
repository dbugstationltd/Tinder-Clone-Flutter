import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    print(_user);

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var data = {
      'providerName': 'google',
      'providerAccessToken': googleAuth.accessToken,
    };

    try {
      Response response = await CallApi().postData(data, socialLoginRoute);
      final SharedPreferences prefs = await _prefs;
      Map responseBody = response.data;

      if ((responseBody['success'] != null) &&
          (responseBody['success'] == true)) {
        prefs.setString(sApiToken, responseBody['apiToken']);
        if (responseBody['availableSubscription'] != null) {
          prefs.setString(sAvailableSubscription,
              jsonEncode(responseBody['availableSubscription']));
        }
        try {
          Response response = await CallApi().getData(userProfileRoute);
          Map responseBody = response.data;
          if (responseBody['success'] != null) {
            if (responseBody['success'] == true) {
              prefs.setString(sUser, jsonEncode(responseBody['data']));
            } else {
              ToastMaker().simpleErrorToast(defaultErrorMsg);
            }
          }
        } catch (e) {
          print("error");
          ToastMaker().simpleErrorToast(defaultErrorMsg);
        }
      } else {
        if (responseBody['message'] != null) {
          ToastMaker().simpleErrorToast(responseBody['message']);
        } else {
          ToastMaker().simpleErrorToast(defaultErrorMsg);
        }
      }
    } catch (e) {
      ToastMaker().simpleErrorToast(defaultErrorMsg);
    }

    // await Future.delayed(Duration(seconds: 5));
    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();

    notifyListeners();
  }
}
