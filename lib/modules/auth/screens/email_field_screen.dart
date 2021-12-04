import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/modules/auth/provider/google_sign_in.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailFieldScreen extends StatefulWidget {
  @override
  _EmailFieldScreenState createState() => _EmailFieldScreenState();
}

class _EmailFieldScreenState extends State<EmailFieldScreen> {
  String email = '';
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
                      "Your email is?",
                      style: TextStyle(
                        color: kSecondaryTextColor,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  SizedBox(height: 47),
                  Text(
                    "We will send you an one time verification code to this Email Address",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kHintTextColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
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
                        email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
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
                  SizedBox(height: 100),
                  _isLoading
                      ? CircularLoading(color: kPrimaryColor)
                      : _buildContinueBtn(email),
                  SizedBox(height: kDefaultPadding),
                  email != ""
                      ? SizedBox()
                      : Text(
                          'Or',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kHintTextColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                          ),
                        ),
                  SizedBox(height: kDefaultPadding),
                  email != ""
                      ? SizedBox()
                      : _buildSocialLoginButton(
                          'assets/icons/google.png', 'LOG IN WITH GOOGLE'),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton(String iconImage, String loginText) {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 0.0,
      ),
      fillColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: kSecondaryTextColor),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image(
              image: AssetImage(iconImage),
              height: 34,
              width: 34,
            ),
            Center(
              child: Text(
                loginText,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF474747),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
          ],
        ),
      ),
      onPressed: () {
        if (loginText == "LOG IN WITH GOOGLE") {
          final provider =
              Provider.of<GoogleSignInProvider>(this.context, listen: false);
          provider.googleLogin();
        } else if (loginText == "LOG IN WITH PHONE NUMBER") {
          Navigator.push(
            this.context,
            MaterialPageRoute(
              builder: (context) => PhoneNumberScreen(),
            ),
          );
        } else {
          Navigator.push(
            this.context,
            MaterialPageRoute(
              builder: (context) => const BottomNavScreen(),
            ),
          );
        }
      },
    );
  }

  Widget _buildContinueBtn(String email) {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: email.length > 0
            ? BoxDecoration(
                gradient: kGradientDefauldButtonStyle,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              )
            : BoxDecoration(
                color: kDisableColor,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
        child: Container(
          constraints: BoxConstraints(), // min sizes for Material buttons
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
                    email.length > 0 ? kPrimaryTextColor : kSecondaryTextColor,
              ),
            ),
          ),
        ),
      ),
      onPressed: _handleEmail,
    );
  }

  void _handleEmail() async {
    if (email != "") {
      bool internetConnected = await CheckInternet().checkInternet();

      if (internetConnected != true) {
        return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
      }
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
      });

      var data = {
        'email': email,
      };

      try {
        // FormData formData = new FormData.fromMap(data);
        Response response = await CallApi().postData(data, emailSubmitRoute);
        final SharedPreferences prefs = await _prefs;
        Map responseBody = response.data;
        if ((responseBody['success'] != null) &&
            (responseBody['success'] == true)) {
          if (responseBody['user'] != null) {
            var _user = prefs.getString(sUser);
            var user = json.decode(_user!);
            user['email'] = email;
            prefs.setString(sUser, jsonEncode(user));
          }
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => AgreeScreen(),
            ),
          );
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
      ToastMaker().simpleErrorToast("Please enter your email");
    }
  }
}
