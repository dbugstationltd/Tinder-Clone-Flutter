import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/modules/auth/provider/google_sign_in.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: _buldBody(),
        ),

        // StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasData) {
        //       print("asdf");
        //       print(snapshot);
        //       return BottomNavScreen();
        //     } else {
        //       return AnnotatedRegion<SystemUiOverlayStyle>(
        //         value: SystemUiOverlayStyle.light,
        //         child: _buldBody(),
        //       );
        //     }
        //   },
        // ),
      );

  Widget _buldBody() => GestureDetector(
        onTap: () => FocusScope.of(this.context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kPrimaryColor,
                    kSecondaryColor,
                  ],
                  stops: [0.1, 0.7],
                ),
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: 14.0, right: 14.0, top: 88.0, bottom: 14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Text(
                      'By clicking “Log in” you are agree with our terms and conditions. Learn how to protect your data in our privacy policy and cookies policy',
                      style:
                          GoogleFonts.roboto(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 54.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: MediaQuery.of(this.context).size.width,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Email',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
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
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: kSecondaryTextColor,
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
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
                                            color: kPrimaryTextColor,
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
                                      'Password',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
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
                                      decoration: InputDecoration(
                                        hintText: '...............',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: kSecondaryTextColor,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0)),
                                          borderSide: BorderSide(
                                            color: kSecondaryTextColor,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0)),
                                          borderSide: BorderSide(
                                            color: kPrimaryTextColor,
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _buildRememberMeCheckBox(),
                    const SizedBox(height: 10.0),
                    _isLoading
                        ? CircularLoading(color: kPrimaryColor)
                        : _buildLoginButton(),
                    const SizedBox(height: 10.0),
                    _buildRegisterButton(),
                    const SizedBox(height: 10.0),
                    _buildSocialLoginButton(
                        'assets/icons/facebook.png', 'LOG IN WITH FACEBOOK'),
                    const SizedBox(height: 10.0),
                    _buildSocialLoginButton(
                        'assets/icons/google.png', 'LOG IN WITH GOOGLE'),
                    const SizedBox(height: 10.0),
                    _buildSocialLoginButton(
                        'assets/icons/number.png', 'LOG IN WITH PHONE NUMBER'),
                    const SizedBox(height: 29.0),
                    _buildtroubleLoginBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget _buildSocialLoginButton(String iconImage, String loginText) {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 0.0,
      ),
      fillColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
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

  Widget _buildLoginButton() {
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
              'Login',
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF474747),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      onPressed: _handleLogin,
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      bool internetConnected = await CheckInternet().checkInternet();

      if (internetConnected != true) {
        return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
      }
      FocusScope.of(this.context).requestFocus(FocusNode());

      setState(() {
        _isLoading = true;
      });

      var data = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      try {
        // FormData formData = new FormData.fromMap(data);
        Response response = await CallApi().postData(data, '/localLogin');
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
          if (responseBody['availableSubscription'] != null) {
            prefs.setString(sAvailableSubscription,
                jsonEncode(responseBody['availableSubscription']));
          }

          if (responseBody['user']['gender'] == null) {
            await Navigator.of(this.context).pushNamedAndRemoveUntil(
                setGenderRoute, (Route<dynamic> route) => false);
          }
          await Navigator.of(this.context).pushNamedAndRemoveUntil(
              bottomNavRoute, (Route<dynamic> route) => false);
        } else {
          if (responseBody['message'] != null) {
            ToastMaker().simpleErrorToast(responseBody['message']);
          } else {
            ToastMaker().simpleErrorToast(defaultErrorMsg);
          }
        }
      } catch (e) {
        print(e);
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

  Widget _buildRegisterButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 0.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Color(0xFFFEE123)),
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
                color: Color(0xFFFEE123),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
      },
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ForgotPassScreen(),
            ),
          );
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Color(0xFFFEE123),
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }

  Widget _buildtroubleLoginBtn() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            this.context,
            CupertinoPageRoute(
              builder: (context) => const ResetPassScreen(),
            ),
          );
        },
        child: Text(
          'Trouble Login In?',
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              'Remember me?',
              style: kLabelStyle,
            ),
          ],
        ),
        _buildForgotPasswordBtn(),
      ],
    );
  }
}
