import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppOpenLoading extends StatefulWidget {
  @override
  _AppOpenLoadingState createState() => _AppOpenLoadingState();
}

class _AppOpenLoadingState extends State<AppOpenLoading> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var user;

  @override
  void initState() {
    _checkLoggedInUser();
    super.initState();
  }

  void _checkLoggedInUser() async {
    SharedPreferences prefs = await _prefs;
    // await prefs.clear();
    print(prefs.containsKey(sApiToken));
    if (prefs.containsKey(sApiToken)) {
      print(prefs.getString(sApiToken));
      var _user = await prefs.getString(sUser);
      setState(() {
        user = json.decode(_user!);
      });
      print(user);
      if ((user.containsKey('email') && (user['email'] == null)) ||
          !user.containsKey('email')) {
        await Navigator.of(context).pushNamedAndRemoveUntil(
            emailSubmitRoute, (Route<dynamic> route) => false);
      } else if ((user.containsKey('birthdate') && (user['birthdate'] == 0)) ||
          !user.containsKey('birthdate')) {
        await Navigator.of(context).pushNamedAndRemoveUntil(
            birthSubmitRoute, (Route<dynamic> route) => false);
      } else if (user.containsKey('gender') && user['gender'] == null) {
        await Navigator.of(context).pushNamedAndRemoveUntil(
            setGenderRoute, (Route<dynamic> route) => false);
      } else if ((user.containsKey('photos') && (user['photos'] == null)) ||
          !user.containsKey('photos')) {
        await Navigator.of(context).pushNamedAndRemoveUntil(
            uploadUserPhotosRoute, (Route<dynamic> route) => false);
      } else if ((user.containsKey('school') && (user['school'] == null)) ||
          !user.containsKey('school')) {
        await Navigator.of(context).pushNamedAndRemoveUntil(
            schoolSubmitRoute, (Route<dynamic> route) => false);
      } else if (user.containsKey('latitude') && (user['latitude'] == null)) {
        await Navigator.of(context).pushNamedAndRemoveUntil(
            locationPermissionRoute, (Route<dynamic> route) => false);
      } else {
        await Navigator.of(context).pushNamedAndRemoveUntil(
            bottomNavRoute, (Route<dynamic> route) => false);
      }
    } else {
      await Navigator.of(context).pushNamedAndRemoveUntil(
          loginViewRoute, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            loginViewRoute, (Route<dynamic> route) => false);
      },
      child: Container(
        color: kPrimaryTextColor,
        child: Center(
          child: CircularLoading(color: kPrimaryColor),
        ),
      ),
    );
  }
}
