import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMaker {
  simpleToast(text) {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.grey[400],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  simpleErrorToast(text) {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.grey[400],
      textColor: Colors.red,
      fontSize: 16.0,
    );
  }
}
