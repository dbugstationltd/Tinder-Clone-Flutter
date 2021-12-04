import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/check_internet.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/helpers/toast_maker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseGenderScreen extends StatefulWidget {
  @override
  _ChooseGenderScreenState createState() => _ChooseGenderScreenState();
}

class _ChooseGenderScreenState extends State<ChooseGenderScreen> {
  String gender = "male";
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryTextColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding),
                  child: Text(
                    "I am a",
                    style: TextStyle(
                      color: kSecondaryTextColor,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 164,
                  height: 164,
                  decoration: gender == "male"
                      ? BoxDecoration(
                          gradient: kGradientNextButtonStyle,
                          borderRadius: BorderRadius.circular(100),
                        )
                      : BoxDecoration(
                          color: Color(0xFFF7F6FB),
                          borderRadius: BorderRadius.circular(100),
                        ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        this.gender = "male";
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                          child: Image(
                            width: 65,
                            height: 65,
                            image: AssetImage(
                              "assets/icons/male.png",
                            ),
                          ),
                        ),
                        Text(
                          "Male",
                          style: TextStyle(
                            color: gender == "male"
                                ? kPrimaryTextColor
                                : kSecondaryTextColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding * 3),
                Container(
                  width: 164,
                  height: 164,
                  decoration: gender == "female"
                      ? BoxDecoration(
                          gradient: kGradientNextButtonStyle,
                          borderRadius: BorderRadius.circular(100),
                        )
                      : BoxDecoration(
                          color: Color(0xFFF7F6FB),
                          borderRadius: BorderRadius.circular(100),
                        ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        this.gender = "female";
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                          child: Image(
                            width: 65,
                            height: 65,
                            image: AssetImage(
                              "assets/icons/female.png",
                            ),
                          ),
                        ),
                        Text(
                          "Female",
                          style: TextStyle(
                            color: gender == "female"
                                ? kPrimaryTextColor
                                : kSecondaryTextColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding * 3),
                Container(
                  width: 164,
                  height: 164,
                  decoration: gender == "others"
                      ? BoxDecoration(
                          gradient: kGradientNextButtonStyle,
                          borderRadius: BorderRadius.circular(100),
                        )
                      : BoxDecoration(
                          color: Color(0xFFF7F6FB),
                          borderRadius: BorderRadius.circular(100),
                        ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        this.gender = "others";
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Others",
                          style: TextStyle(
                            color: gender == "others"
                                ? kPrimaryTextColor
                                : kSecondaryTextColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                _isLoading
                    ? CircularLoading(color: kPrimaryColor)
                    : _buildNextButton(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: kGradientDefauldButtonStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 310.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Next',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      onPressed: _handleNextBtn,
    );
  }

  void _handleNextBtn() async {
    if (gender != "") {
      bool internetConnected = await CheckInternet().checkInternet();

      if (internetConnected != true) {
        return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
      }
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
      });

      var data = {
        'gender': gender,
      };

      try {
        // FormData formData = new FormData.fromMap(data);
        Response response = await CallApi().postData(data, setGenderRoute);
        final SharedPreferences prefs = await _prefs;
        Map responseBody = response.data;
        if ((responseBody['success'] != null) &&
            (responseBody['success'] == true)) {
          var _user = prefs.getString(sUser);
          var user = json.decode(_user!);
          user['gender'] = gender;
          prefs.setString(sUser, jsonEncode(user));
          setState(() {
            _isLoading = false;
          });
          await Navigator.of(context).pushNamed(schoolSubmitRoute);
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
    }
  }
}
