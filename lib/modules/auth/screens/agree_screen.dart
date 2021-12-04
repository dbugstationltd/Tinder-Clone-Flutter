import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';

class AgreeScreen extends StatefulWidget {
  @override
  State<AgreeScreen> createState() => _AgreeScreenState();
}

class _AgreeScreenState extends State<AgreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  Image(
                    height: 78,
                    width: 78,
                    image: AssetImage("assets/images/logo.png"),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Text(
                    "Welcome to Ashiqui.",
                    style: TextStyle(
                      color: kSecondaryTextColor,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto",
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Text(
                    "Please follow this house rules",
                    style: TextStyle(
                      color: kHintTextColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                    ),
                  ),
                  SizedBox(height: 47),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_rounded,
                                color: kPrimaryColor,
                              ),
                              SizedBox(width: kDefaultPadding),
                              Text(
                                "Be Yourself",
                                style: TextStyle(
                                  color: kSecondaryTextColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Make sure your photos, age and bio\nare true to who you are.",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: kHintTextColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: kDefaultPadding * 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: kDefaultPadding),
                      Text(
                        "Stay Safe",
                        style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Don't be too quick to give out personal\ninformation. Date Safely",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: kHintTextColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding * 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: kDefaultPadding),
                      Text(
                        "Play it cool",
                        style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Respect others and treat them as you\nwould like to be treated.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: kHintTextColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding * 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: kDefaultPadding),
                      Text(
                        "Be proactive",
                        style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Always report bad behaviour.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: kHintTextColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding * 3),
                  _buildAgreeBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgreeBtn() {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () {
        Navigator.of(this.context).pushNamed(nameSubmitRoute);
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 310.0,
        ), // min sizes for Material buttons
        decoration: BoxDecoration(
          gradient: kGradientDefauldButtonStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'I AGREE',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: kPrimaryTextColor),
          ),
        ),
      ),
    );
  }
}
