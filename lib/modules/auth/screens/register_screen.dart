import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
              // ignore: sized_box_for_whitespace
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 26.0,
                    right: 27.0,
                    top: 84.0,
                    bottom: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        color: kPrimaryTextColor,
                        child: Center(
                          child: Image(
                            image: AssetImage('assets/images/icon.png'),
                            height: 50,
                            width: 200,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Create an account',
                                style: TextStyle(
                                  color: Color(0xFFFEE123),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.0,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // ignore: sized_box_for_whitespace
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        'Name',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter your username';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          color: kPrimaryTextColor,
                                        ),
                                        controller: nameController,
                                        minLines: 1,
                                        maxLines: 1,
                                        autocorrect: false,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter your username',
                                          hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          errorStyle: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            color: kSecondaryTextColor,
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kPrimaryTextColor,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kSecondaryTextColor,
                                            ),
                                          ),
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.only(
                                            top: 5.0,
                                            left: 20.0,
                                          ),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAEAEC),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30.0),
                                            ),
                                            borderSide: BorderSide(
                                                color: Color(0xFFEAEAEC)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text(
                                        'Email',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter your email';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          color: kPrimaryTextColor,
                                        ),
                                        controller: emailController,
                                        minLines: 1,
                                        maxLines: 1,
                                        autocorrect: false,
                                        decoration: const InputDecoration(
                                          hintText: 'email@example.com',
                                          hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          errorStyle: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            color: kSecondaryTextColor,
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kPrimaryTextColor,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kSecondaryTextColor,
                                            ),
                                          ),
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.only(
                                              top: 10.0, left: 20.0),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAEAEC),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAEAEC),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      const Text(
                                        'Mobile',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter your mobile no';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          color: kPrimaryTextColor,
                                        ),
                                        controller: mobileController,
                                        minLines: 1,
                                        maxLines: 1,
                                        autocorrect: false,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter your mobile no',
                                          hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          errorStyle: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            color: kSecondaryTextColor,
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kPrimaryTextColor,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kSecondaryTextColor,
                                            ),
                                          ),
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.only(
                                              top: 10.0, left: 20.0),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAEAEC),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAEAEC),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text(
                                        'Password',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter password';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          color: kPrimaryTextColor,
                                        ),
                                        controller: passwordController,
                                        minLines: 1,
                                        maxLines: 1,
                                        autocorrect: false,
                                        obscureText: true,
                                        enableSuggestions: false,
                                        decoration: const InputDecoration(
                                          hintText: 'Your password',
                                          hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                          errorStyle: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            color: kSecondaryTextColor,
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kPrimaryTextColor,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kSecondaryTextColor,
                                            ),
                                          ),
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.only(
                                              top: 10.0, left: 20.0),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAEAEC),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAEAEC),
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              Icons.visibility,
                                              color: Color(0xFFBABFCC),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text(
                                        'Confirm Password',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Re-enter your password';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          color: kPrimaryTextColor,
                                        ),
                                        controller: confirmPpasswordController,
                                        minLines: 1,
                                        maxLines: 1,
                                        autocorrect: false,
                                        obscureText: true,
                                        enableSuggestions: false,
                                        decoration: const InputDecoration(
                                          hintText: 'Re-enter your password',
                                          hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          errorStyle: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            color: kSecondaryTextColor,
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kPrimaryTextColor,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: kSecondaryTextColor,
                                            ),
                                          ),
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.only(
                                              top: 10.0, left: 20.0),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAEAEC),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAEAEC),
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              Icons.visibility,
                                              color: Color(0xFFBABFCC),
                                            ),
                                          ),
                                        ),
                                      ),
                                      _buildAgreeCheckBox(),
                                      const SizedBox(height: kDefaultPadding),
                                      _isLoading
                                          ? CircularLoading(
                                              color: kPrimaryColor)
                                          : _buildRegisterButton(),
                                      const SizedBox(height: kDefaultPadding),
                                      _buildAlreadyAccoutnBtn(),
                                      const SizedBox(height: kDefaultPadding),
                                      Center(
                                        child: Text(
                                          'Trouble Login In?',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgreeCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.white,
              ),
              child: Checkbox(
                value: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                checkColor: const Color(0xFF2196F3),
                activeColor: Colors.yellow,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            const Text(
              'I agree to Loverias  terms of service and privacy policy',
              style: TextStyle(
                color: Color(0xFFFEE123),
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
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
              'Register',
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
      onPressed: _handleRegister,
    );
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      bool internetConnected = await CheckInternet().checkInternet();

      if (internetConnected != true) {
        return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
      }
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
      });

      var data = {
        'name': nameController.text,
        'email': emailController.text,
        'contactNo': mobileController.text,
        'password': passwordController.text,
        'password_confirmation': passwordController.text,
      };

      try {
        // FormData formData = new FormData.fromMap(data);
        Response response = await CallApi().postData(data, localRegisterRoute);
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
          await Navigator.of(context).pushNamedAndRemoveUntil(
              setGenderRoute, (Route<dynamic> route) => false);
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

      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildAlreadyAccoutnBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            fontFamily: 'Roboto',
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: const Text(
            'Sign in',
            style: TextStyle(
              color: Color(0xFFFEE123),
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ],
    );
  }
}
