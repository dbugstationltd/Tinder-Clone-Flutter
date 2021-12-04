import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/modules/auth/screens/email_field_screen.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginOtpVerifyScreen extends StatefulWidget {
  final String verificationId;
  final String mobile;
  const LoginOtpVerifyScreen({Key? key, required this.verificationId, required this.mobile})
      : super(key: key);

  @override
  _LoginOtpVerifyScreenState createState() => _LoginOtpVerifyScreenState();
}

class _LoginOtpVerifyScreenState extends State<LoginOtpVerifyScreen> {
  final otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;
  String otp = "";

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      // showLoading = true;
    });
    print(phoneAuthCredential);

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        // showLoading = false;
      });

      if (authCredential.user != null) {
        print("not reg");
        var data = {
          'phone': widget.mobile,
        };

        try {
          Response response =
              await CallApi().postData(data, createUserWithPhone);
          final SharedPreferences prefs = await _prefs;
          Map responseBody = response.data;
          if ((responseBody['success'] != null) &&
              (responseBody['success'] == true)) {
            if (responseBody['user'] != null) {
              prefs.setString(sUser, jsonEncode(responseBody['user']));
            }

            if (responseBody['apiToken'] != null) {
              prefs.setString(sApiToken, responseBody['apiToken']);
            }
            setState(() {
              _isLoading = false;
            });
            await Navigator.of(context).pushNamedAndRemoveUntil(
                appOpeningRoute, (Route<dynamic> route) => false);
          } else {
            setState(() {
              _isLoading = false;
            });
            if (responseBody['message'] != null) {
              ToastMaker().simpleErrorToast(responseBody['message']);
            } else {
              ToastMaker().simpleErrorToast(defaultErrorMsg);
            }
            await Navigator.of(context).pushNamedAndRemoveUntil(
                loginViewRoute, (Route<dynamic> route) => false);
          }
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          ToastMaker().simpleErrorToast(defaultErrorMsg);
        }
      } else {
        print("else");
        Navigator.of(context).pushNamedAndRemoveUntil(
            loginViewRoute, (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
      // test_start
      // var data = {
      //     'phone': widget.mobile,
      //   };

      //   try {
      //     print(2);
      //     Response response =
      //         await CallApi().postData(data, createUserWithPhone);
      //     final SharedPreferences prefs = await _prefs;
      //     Map responseBody = response.data;
      //     print("login response");
      //     print(responseBody);
      //     if ((responseBody['success'] != null) &&
      //         (responseBody['success'] == true)) {
      //       if (responseBody['user'] != null) {
      //         prefs.setString(sUser, jsonEncode(responseBody['user']));
      //       }
      //       print(responseBody['user']);

      //       if (responseBody['apiToken'] != null) {
      //         prefs.setString(sApiToken, responseBody['apiToken']);
      //       }
      //       setState(() {
      //         _isLoading = false;
      //       });
      //       await Navigator.of(context).pushNamedAndRemoveUntil(
      //           appOpeningRoute, (Route<dynamic> route) => false);
      //     } else {
      //       setState(() {
      //         _isLoading = false;
      //       });
      //       if (responseBody['message'] != null) {
      //         ToastMaker().simpleErrorToast(responseBody['message']);
      //       } else {
      //         ToastMaker().simpleErrorToast(defaultErrorMsg);
      //       }
      //       await Navigator.of(context).pushNamedAndRemoveUntil(
      //           loginViewRoute, (Route<dynamic> route) => false);
      //     }
      //   } catch (e) {
      //     print(3);
      //     setState(() {
      //       _isLoading = false;
      //     });
      //     ToastMaker().simpleErrorToast(defaultErrorMsg);
      //   }
        // test end
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 26.0,
                  right: 26.0,
                  top: 110.0,
                  bottom: 26.0,
                ),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'My Verification Code',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 26.0,
                        color: kSecondaryTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 57.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Enter the OTP sent to',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15.0,
                            color: kHintTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15.0,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          // borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: kPrimaryColor,
                          activeColor: kPrimaryColor,
                          inactiveColor: Colors.black,
                          inactiveFillColor: Colors.transparent,
                          selectedFillColor: Colors.transparent,
                          selectedColor: kPrimaryColor,
                        ),
                        backgroundColor: Colors.transparent,
                        cursorColor: kPrimaryColor,
                        // animationDuration: const Duration(milliseconds: 500),
                        enableActiveFill: false,
                        keyboardType: TextInputType.number,
                        textStyle: const TextStyle(
                          backgroundColor: Colors.transparent,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                        ),
                        onChanged: (String value) {
                          setState(() {
                            this.otp = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Didn’t you received any OTP?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14.0,
                            color: kHintTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' Resend OTP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14.0,
                            color: Color(0xFFFEE123),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 115.0),
                    _isLoading
                        ? CircularLoading(color: kPrimaryColor)
                        : _buildContinueBtn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueBtn() {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: otp.length > 5
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
              'Continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: otp.length > 0 ? kPrimaryTextColor : kSecondaryTextColor,
              ),
            ),
          ),
        ),
      ),
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        print("verification id: ");
        print(widget.verificationId);
        if (this.otp.length > 5) {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
            verificationId: widget.verificationId,
            smsCode: this.otp,
          );
          print("phon auth");
          signInWithPhoneAuthCredential(phoneAuthCredential);
        }
      },
    );
  }
}
