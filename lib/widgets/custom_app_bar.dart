import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/modules/auth/provider/google_sign_in.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var user;
  String profileImage = defaultNoImageUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _getUserInfo());
  }

  void _getUserInfo() async {
    SharedPreferences prefs = await _prefs;
    if (prefs.containsKey(sUser)) {
      var _user = prefs.getString(sUser);
      setState(() {
        this.user = json.decode(_user!);
        profileImage = photoBucket + user['profile_pic'];
      });
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
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Container(
        decoration: BoxDecoration(
          gradient: kGradientPageStyle,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: CachedNetworkImage(
                imageUrl: profileImage,
                fit: BoxFit.cover,
                height: 32,
                width: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
