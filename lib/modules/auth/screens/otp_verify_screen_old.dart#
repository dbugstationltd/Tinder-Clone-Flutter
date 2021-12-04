import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({Key? key}) : super(key: key);

  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                decoration: const BoxDecoration(
                  gradient: kGradientPageStyle,
                ),
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
                    const Image(
                      image: AssetImage('assets/images/verify.png'),
                      height: 221,
                      width: 221,
                    ),
                    const SizedBox(height: 57.0),
                    const Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 26.0,
                        color: Color(0xFFFFFFFF),
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
                            color: Color(0xFFFFFFFF),
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
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            // borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.transparent,
                            activeColor: Colors.transparent,
                            inactiveColor: Colors.white,
                            inactiveFillColor: Colors.transparent,
                            selectedFillColor: Colors.transparent,
                            selectedColor: Colors.white,
                          ),
                          backgroundColor: Colors.transparent,
                          cursorColor: Colors.yellow,
                          // animationDuration: const Duration(milliseconds: 500),
                          enableActiveFill: false,
                          keyboardType: TextInputType.number,
                          textStyle: const TextStyle(
                            backgroundColor: Colors.transparent,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                          ),
                          onChanged: (String value) {},
                        ),
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
                            color: Color(0xFFFFFFFF),
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
                    _buildVerifyButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotNowButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 0.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: kSecondaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const <Widget>[
            Text(
              'Not Now',
              maxLines: 1,
              style: TextStyle(
                fontSize: 22.0,
                color: kSecondaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _buildAllowButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: kGradientButtonStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 88.0,
            minHeight: 36.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 10.0,
            ),
            child: Text(
              'Allow Location',
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
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ChooseGenderScreen(),
          ),
        );
      },
    );
  }

  Widget _buildVerifyButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 0.0,
      ),
      fillColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Color(0xFFFFFFFF)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const <Widget>[
            Text(
              'Verify',
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF474747),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      onPressed: _handleVerifyOtp,
    );
  }

  void _locatePermissionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext buildContext) {
        return Container(
          height: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/images/location.png'),
                  height: 134,
                  width: 134,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Allow your Location',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 26.0,
                      color: Color(0xFF474747),
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'We will need your location to give you a better experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.0,
                    color: Color(0xFFA2A2A2),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNotNowButton(),
                    _buildAllowButton(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      Navigator.of(context).pushNamedAndRemoveUntil(
          loginViewRoute, (Route<dynamic> route) => false);
    });
  }

  void _handleVerifyOtp() {
    _locatePermissionModal();
  }
}
