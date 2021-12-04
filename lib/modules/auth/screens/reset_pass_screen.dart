import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({Key? key}) : super(key: key);

  @override
  _ResetPassScreenState createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  Widget _buildSubmitButton() {
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
              'Submit',
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
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
    );
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
                decoration: const BoxDecoration(
                  gradient: kGradientPageStyle,
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 26.0,
                    right: 26.0,
                    top: 110.0,
                    bottom: 26.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/reset_pass.png'),
                        height: 221,
                        width: 221,
                      ),
                      const SizedBox(height: 57.0),
                      const Text(
                        'Reset Your Password',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 26.0,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        'New Password',
                        textAlign: TextAlign.start,
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
                        controller: passwordController,
                        minLines: 1,
                        maxLines: 1,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: 'Your password',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.only(top: 10.0, left: 20.0),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Color(0xFFEAEAEC),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
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
                        controller: rePasswordController,
                        minLines: 1,
                        maxLines: 1,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: 'Re-enter your password',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.only(top: 10.0, left: 20.0),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Color(0xFFEAEAEC),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
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
                      const SizedBox(height: 85.0),
                      _buildSubmitButton(),
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
}
