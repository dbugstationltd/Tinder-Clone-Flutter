import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String verificationId = "";
  bool is_phone_number = false;
  String phone_number = '';
  TextEditingController numberController = TextEditingController();
  bool cont = false;
  String countryCode = '+88';
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    cont = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) =>
            GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.minHeight,
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: kDefaultPadding * 4),
                      child: Text(
                        "My Phone Number",
                        style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 2),
                    Text(
                      "We will send you an one time verification code to this mobile number. Message or data rate may apply. Varified phone number can be used to log in. Learn what happen when your number changes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kHintTextColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 3),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                            horizontal: kDefaultPadding),
                        child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: kPrimaryColor),
                                ),
                              ),
                              child: CountryCodePicker(
                                onChanged: (value) {
                                  countryCode = value.dialCode!;
                                },
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'BD',
                                favorite: [countryCode, 'BD'],
                                // optional. Shows only country name and flag
                                showCountryOnly: false,
                                // optional. Shows only country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: false,
                                // optional. aligns the flag and the Text left
                                alignLeft: false,
                              ),
                            ),
                            title: Container(
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                style: TextStyle(fontSize: 20),
                                cursorColor: kPrimaryColor,
                                controller: numberController,
                                onChanged: (value) {
                                  setState(() {
                                    cont = true;
                                    this.phone_number = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter your number",
                                  hintStyle: TextStyle(fontSize: 18),
                                  focusColor: kPrimaryColor,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                ),
                              ),
                            ))),
                    SizedBox(height: kDefaultPadding * 4),
                    _isLoading
                        ? CircularLoading(color: kPrimaryColor)
                        : _buildContinueBtn(this.phone_number),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueBtn(String phone_number) {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: phone_number.length > 4
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
                color: phone_number.length > 4
                    ? kPrimaryTextColor
                    : kSecondaryTextColor,
              ),
            ),
          ),
        ),
      ),
      onPressed: () async {
        if (phone_number.length < 5) return;

        setState(() {
          _isLoading = true;
          phone_number = countryCode + phone_number.toString();
          phone_number = phone_number.toString().trim();
        });
        // await _auth.userChanges();

        await _auth.verifyPhoneNumber(
          phoneNumber: phone_number,
          verificationCompleted: (phoneAuthCredential) async {
            setState(() {
              _isLoading = false;
            });
          },
          verificationFailed: (verificationFailed) async {
            setState(() {
              _isLoading = false;
            });
            ToastMaker().simpleErrorToast(defaultErrorMsg);
            print(verificationFailed);

            // for_test
            // if (phone_number.length > 8) {
            //   await Navigator.push(
            //     context,
            //     PageRouteBuilder(
            //       pageBuilder: (context, animation1, animation2) =>
            //           LoginOtpVerifyScreen(
            //               verificationId: this.verificationId,
            //               mobile: this.phone_number),
            //     ),
            //   );
            // }
            // test_end
          },
          codeSent: (verificationId, resendingToken) async {
            setState(() {
              // isLoading = false;
              this.verificationId = verificationId;
            });

            if (phone_number.length > 8) {
              await Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      LoginOtpVerifyScreen(
                    verificationId: this.verificationId,
                    mobile: this.phone_number,
                  ),
                ),
              );
            }
          },
          codeAutoRetrievalTimeout: (verificationId) async {},
        );
      },
    );
  }
}
