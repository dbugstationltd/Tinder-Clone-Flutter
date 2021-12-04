import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/helpers/toast_maker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BirthSubmitScreen extends StatefulWidget {
  @override
  _BirthSubmitScreenState createState() => _BirthSubmitScreenState();
}

class _BirthSubmitScreenState extends State<BirthSubmitScreen> {
  DateTime date = DateTime(1990, 1, 1);
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Center(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: kDefaultPadding * 8),
                    child: Text(
                      "My birthday is",
                      style: TextStyle(
                        color: kSecondaryTextColor,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Container(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime(1969, 1, 1),
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(() {
                          date = newDateTime;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Text(
                    "Your age will be public.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kHintTextColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                    ),
                  ),
                  SizedBox(height: 100),
                  _isLoading
                      ? CircularLoading(color: kPrimaryColor)
                      : _buildContinueBtn(date),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueBtn(DateTime date) {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration:
            // date.
            // ?
            BoxDecoration(
          gradient: kGradientDefauldButtonStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        // : BoxDecoration(
        //     color: kDisableColor,
        //     borderRadius: BorderRadius.all(Radius.circular(30.0)),
        //   ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 310.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'CONTINUE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: kPrimaryTextColor,
              ),
            ),
          ),
        ),
      ),
      onPressed: _handleContinueBtn,
    );
  }

  void _handleContinueBtn() async {
    if (date != "") {
      bool internetConnected = await CheckInternet().checkInternet();

      if (internetConnected != true) {
        return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
      }
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
      });

      var _bdate = Helper().getFirstWord(date.toString());

      var data = {
        'birthdate': _bdate,
      };

      try {
        // FormData formData = new FormData.fromMap(data);
        Response response = await CallApi().postData(data, birthSubmitRoute);
        final SharedPreferences prefs = await _prefs;
        Map responseBody = response.data;
        if ((responseBody['success'] != null) &&
            (responseBody['success'] == true)) {
          if (responseBody['user'] != null) {
            var _user = prefs.getString(sUser);
            var user = json.decode(_user!);
            user['birthdate'] = responseBody['user']['birthdate'];
            prefs.setString(sUser, jsonEncode(user));
          }
          setState(() {
            _isLoading = false;
          });
          await Navigator.of(context).pushNamed(setGenderRoute);
        } else {
          if (responseBody['message'] != null) {
            ToastMaker().simpleErrorToast(responseBody['message']);
          } else {
            ToastMaker().simpleErrorToast(defaultErrorMsg);
          }
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ToastMaker().simpleErrorToast(defaultErrorMsg);
      }
    } else {
      ToastMaker().simpleErrorToast("Please enter your birthday");
    }
  }
}
