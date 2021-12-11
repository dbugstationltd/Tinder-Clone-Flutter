export 'package:loveria/utils/helpers/check_internet.dart';
export 'package:loveria/utils/helpers/constants.dart';
export 'package:loveria/utils/helpers/enums.dart';
export 'package:loveria/utils/helpers/styles.dart';
export 'package:loveria/utils/helpers/toast_maker.dart';
export 'package:loveria/utils/helpers/firebase_enums.dart';
export 'package:loveria/utils/helpers/local_storage_enums.dart';
export 'package:loveria/utils/screens/screen.dart';

import 'package:flutter/material.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/enums.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {

  String getDate(String inputString) {
    if (inputString.length > 0) {
      List<String> wordList = inputString.split(" ");
      return wordList[0];
    } else {
      return ' ';
    }
  }

  String getNameFirstWord(String inputString) {
    if (["", null, false, 0].contains(inputString)) {
      return 'Jhon';
    } else {
      List<String> wordList = inputString.split(" ");
      return wordList[0];
    }
  }

  String checkNullString(String inputString) {
    if (["", null, false, 0].contains(inputString)) {
      return '';
    } else {
      return inputString;
    }
  }

  String getImageUrl(String url) {
    var imgUrl = defaultNoImageUrl;
    if (["", null, false, 0].contains(url)) {
      return imgUrl;
    } else {
      return imgUrl = photoBucket + url;
    }
  }

  String getLastThreeImageUrl(List url) {
    var imgUrl = defaultNoImageUrl;
    if (["", null, false, 0].contains(url) || url.length == 0) {
      return imgUrl;
    } else {
      return imgUrl = photoBucket + url[0]['imageUrl'];
    }
  }

  void checkLoggedInUser(BuildContext context) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;

    if (!prefs.containsKey(sApiToken)) {
      await Navigator.of(context).pushNamedAndRemoveUntil(
          loginViewRoute, (Route<dynamic> route) => false);
    }
  }
}
