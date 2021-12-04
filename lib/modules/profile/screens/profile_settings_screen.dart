import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:loveria/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _auth = FirebaseAuth.instance;
  bool visibleGlobal = true;
  int distance = 1;
  var user;
  RangeValues ageRange = RangeValues(18.0, 22.0);
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController globalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    setState(() {
      distance = 2;
      ageRange = RangeValues(18, 22);
      visibleGlobal = true;
    });
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences prefs = await _prefs;
    if (prefs.containsKey(sUser)) {
      var _user = prefs.getString(sUser);
      setState(() {
        user = json.decode(_user!);
      });
      print(user);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: TitleAppBar(headerName: 'Settings', elevation: 1),
      ),
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    kDefaultPadding, kDefaultPadding, kDefaultPadding, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone Number",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: kHintTextColor,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    user != null ? user['contactNo'] : "xxxxxx",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: kHintTextColor,
                                ),
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.navigate_next_rounded,
                                  size: 17,
                                  color: kHintTextColor,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(kDefaultPadding, 2, kDefaultPadding, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discovery Settings',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: kHintTextColor,
                          ),
                        ),
                        Text(
                          "My Current Location",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: kSecondaryColor,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    kDefaultPadding, 0, kDefaultPadding, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Global",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: kHintTextColor,
                      ),
                    ),
                    Switch(
                      activeColor: kPrimaryColor,
                      value: false,
                      onChanged: (value) {
                        setState(() {
                          visibleGlobal = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(kDefaultPadding, 2, kDefaultPadding, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Maximum distance',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: kSecondaryTextColor,
                          ),
                        ),
                        Text(
                          "$distance Km.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kSecondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: distance.toDouble(),
                      inactiveColor: kHintTextColor,
                      min: 1.0,
                      max: 120,
                      activeColor: kPrimaryColor,
                      onChanged: (val) {
                        setState(() {
                          distance = val.round();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Show Me',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Male",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: kHintTextColor,
                          ),
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          size: 17,
                          color: kHintTextColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(kDefaultPadding, 2, kDefaultPadding, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Age range',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: kSecondaryTextColor,
                          ),
                        ),
                        Text(
                          "${ageRange.start.round()}-${ageRange.end.round()}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kSecondaryTextColor),
                        ),
                      ],
                    ),
                    RangeSlider(
                      inactiveColor: kHintTextColor,
                      values: ageRange,
                      min: 18.0,
                      max: 100.0,
                      divisions: 100,
                      activeColor: kPrimaryColor,
                      labels: RangeLabels('${ageRange.start.round()}',
                          '${ageRange.end.round()}'),
                      onChanged: (val) {
                        setState(() {
                          ageRange = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    kDefaultPadding, 0, kDefaultPadding, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Show me on Ashiqui",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: kHintTextColor,
                      ),
                    ),
                    Switch(
                      activeColor: kPrimaryColor,
                      value: true,
                      onChanged: (value) {
                        setState(() {
                          visibleGlobal = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact No',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user['contactNo'] != null ? user['contactNo'] : "Add Contact",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: kHintTextColor,
                          ),
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          size: 17,
                          color: kHintTextColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user != null ? user['email'] : "xxxxxx",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: kHintTextColor,
                          ),
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          size: 17,
                          color: kHintTextColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
              InkWell(
                onTap: _handleLogout,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      kDefaultPadding, 0, kDefaultPadding, 2),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: kErrorColor,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: kHintTextColor,
                thickness: 0.70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogout() async {
    SharedPreferences prefs = await _prefs;
    await _auth.signOut();
    FirebaseAuth.instance.signOut();
    await prefs.clear();

    await Navigator.of(context).pushNamedAndRemoveUntil(
        loginViewRoute, (Route<dynamic> route) => false);
  }
}
