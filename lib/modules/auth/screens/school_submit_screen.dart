import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchoolSubmitScreen extends StatefulWidget {
  @override
  _SchoolSubmitScreenState createState() => _SchoolSubmitScreenState();
}

class _SchoolSubmitScreenState extends State<SchoolSubmitScreen> {
  String name = '';
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
                      "My university is",
                      style: TextStyle(
                        color: kSecondaryTextColor,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kSecondaryTextColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'University Name',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                        color: kHintTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Text(
                    "This is how it will appear in Ashiqui, and/you will not be able to change it.",
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
                      : _buildContinueBtn(name),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueBtn(String name) {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: name.length > 2
            ? BoxDecoration(
                gradient: kGradientDefauldButtonStyle,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              )
            : BoxDecoration(
                color: kDisableColor,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
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
                color:
                    name.length > 2 ? kPrimaryTextColor : kSecondaryTextColor,
              ),
            ),
          ),
        ),
      ),
      onPressed: _handleContinueBtn,
    );
  }

  void _handleContinueBtn() async {
    if (name != "") {
      bool internetConnected = await CheckInternet().checkInternet();

      if (internetConnected != true) {
        return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
      }
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
      });

      var data = {
        'school': name,
      };

      try {
        // FormData formData = new FormData.fromMap(data);
        Response response = await CallApi().postData(data, schoolSubmitRoute);
        final SharedPreferences prefs = await _prefs;
        Map responseBody = response.data;
        if ((responseBody['success'] != null) &&
            (responseBody['success'] == true)) {
          if (responseBody['user'] != null) {
            var _user = prefs.getString(sUser);
            var user = json.decode(_user!);
            user['school'] = name;
            prefs.setString(sUser, jsonEncode(user));
          }
          setState(() {
            _isLoading = false;
          });
          await Navigator.of(context).pushNamed(interestViewRoute);
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
      ToastMaker().simpleErrorToast("Please enter your school");
    }
  }
}
