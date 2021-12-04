import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController emailController = TextEditingController();

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
            builder: (context) => const OtpVerifyScreen(),
          ),
        );
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      textAlign: TextAlign.center,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your email';
        }
        return null;
      },
      controller: emailController,
      minLines: 1,
      maxLines: 1,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: 'email@example.com',
        hintStyle: TextStyle(
          fontSize: 22.0,
          color: kWarninngColor,
          fontWeight: FontWeight.w700,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFFFFF),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Image(
                          image: AssetImage('assets/images/verify.png'),
                          height: 221,
                          width: 221,
                        ),
                        const SizedBox(height: 57.0),
                        const Text(
                          'Enter Your Email',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 26.0,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 57.0),
                        const Text(
                          'We will send you an one time verification code to this Email Address',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15.0,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 34.0),
                        const Text(
                          'Enter Email Address',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14.0,
                            color: Colors.white60,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        _buildEmailField(),
                        const SizedBox(height: 140.0),
                        _buildSubmitButton(),
                      ],
                    ),
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
