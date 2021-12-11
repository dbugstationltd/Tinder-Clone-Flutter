import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:loveria/widgets/discover_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({Key? key}) : super(key: key);

  @override
  _RecommendScreenState createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var users = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _getUserInfo());
  }

  void _getUserInfo() async {
    SharedPreferences prefs = await _prefs;
    if (prefs.containsKey(sRecomendedUser)) {
      var _users = prefs.getString(sRecomendedUser);
      setState(() {
        this.users = json.decode(_users!);
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = (size.width / 2) - kDefaultPadding;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: DiscoverAppBar(headerName: 'Recommended'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            children: List.generate(
              users.length,
              (index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          UserProfileScreen(userId: users[index]['id']),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: CachedNetworkImage(
                          imageUrl:
                              Helper().getImageUrl(users[index]['profile_pic']),
                          fit: BoxFit.cover,
                          height: 278.0,
                          width: (MediaQuery.of(context).size.width / 2) -
                              (kDefaultPadding / 1.5),
                        ),
                      ),
                      Positioned(
                        left: 12.0,
                        bottom: 8.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  Helper()
                                      .getNameFirstWord(users[index]['name']),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                                const Text(
                                  ", ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                                  '19',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16.0),
                            Row(
                              children: [
                                Container(
                                  height: 5.94,
                                  width: 5.94,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF09F6A0),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4.06),
                                const Text(
                                  'Recommended',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Lato'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
