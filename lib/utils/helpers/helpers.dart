export 'package:loveria/utils/helpers/check_internet.dart';
export 'package:loveria/utils/helpers/constants.dart';
export 'package:loveria/utils/helpers/enums.dart';
export 'package:loveria/utils/helpers/styles.dart';
export 'package:loveria/utils/helpers/toast_maker.dart';
export 'package:loveria/utils/screens/screen.dart';

import 'package:flutter/material.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  String getFirstWord(String inputString) {
    List<String> wordList = inputString.split(" ");
    if (inputString.length > 0) {
      return wordList[0];
    } else {
      return ' ';
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
