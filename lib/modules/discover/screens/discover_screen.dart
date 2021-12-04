import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/models/models.dart';

import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/local_storage_enums.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool _showTopPics = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;

  List _recentlyActive = [];
  List _commonInterest = [];
  List _recomended = [];

  List get recentlyActive => _recentlyActive;
  List get commonInterest => _commonInterest;
  List get recomended => _recomended;

  @override
  void initState() {
    _checkLoggedInUser();
    _getDiscoverList();
    super.initState();
  }

  void _checkLoggedInUser() async {
    SharedPreferences prefs = await _prefs;

    if (!prefs.containsKey(sApiToken)) {
      await Navigator.of(context).pushNamedAndRemoveUntil(
          loginViewRoute, (Route<dynamic> route) => false);
    }
  }

  Future _getDiscoverList() async {
    bool internetConnected = await CheckInternet().checkInternet();

    if (internetConnected != true) {
      return ToastMaker().simpleErrorToast(checkInternetErrorMsg);
    }
    FocusScope.of(context).requestFocus(FocusNode());

    try {
      final SharedPreferences prefs = await _prefs;
      Response response = await CallApi().getData(userExploreRoute);

      Map responseBody = response.data;
      print(responseBody);
      if (responseBody['success'] != null) {
        if (responseBody['success'] == true) {
          var responseData = responseBody['data'];

          if (responseData[sRecentlyActiveUser] != null) {
            prefs.setString(sRecentlyActiveUser,
                jsonEncode(responseData[sRecentlyActiveUser]));

            var recentlyActiveObjJson =
                responseData[sRecentlyActiveUser] as List;

            setState(() {
              _recentlyActive = recentlyActiveObjJson
                  .map((tagJson) => DiscoverUser.fromJson(tagJson))
                  .toList();
            });
          }

          if (responseData[sCommonInterestUser] != null) {
            prefs.setString(sCommonInterestUser,
                jsonEncode(responseData[sCommonInterestUser]));

            var commonInterestObjJson =
                responseData[sCommonInterestUser] as List;

            setState(() {
              _commonInterest = commonInterestObjJson
                  .map((tagJson) => DiscoverUser.fromJson(tagJson))
                  .toList();
            });
          }

          if (responseData[sRecomendedUser] != null) {
            prefs.setString(
                sRecomendedUser, jsonEncode(responseData[sRecomendedUser]));

            var recomendedObjJson = responseData[sRecomendedUser] as List;

            setState(() {
              _recomended = recomendedObjJson
                  .map((tagJson) => DiscoverUser.fromJson(tagJson))
                  .toList();
            });
          }
        } else {
          await Navigator.of(context).pushNamedAndRemoveUntil(
              loginViewRoute, (Route<dynamic> route) => false);
          if (responseBody['message'] != null) {
            ToastMaker().simpleErrorToast(responseBody['message']);
          } else {
            ToastMaker().simpleErrorToast(defaultErrorMsg);
          }
        }
      }
    } catch (e) {
      print(e);
      ToastMaker().simpleErrorToast(defaultErrorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(),
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _buildDiscoverTabBar(),
          _buildDiscover(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildDiscover() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding * 2,
          bottom: kDefaultPadding * 5,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!_showTopPics) _buildLikedMeWindow(),
              if (_showTopPics) _buildTopPicksWindow()
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildDiscoverTabBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: kDefaultPadding / 2),
        child: DefaultTabController(
          length: 2,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 246.0,
              height: 33.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.5),
                  border: Border.all(color: Colors.white10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.4, 0.1),
                      blurRadius: 6.0,
                    ),
                  ]),
              child: TabBar(
                indicator: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  gradient: kGradientButtonStyle,
                ),
                labelColor: Colors.white,
                labelStyle: dTabTextStyle,
                unselectedLabelColor: const Color(0xFFABABAC),
                tabs: const [
                  Text('250 Likes'),
                  Text('Top Picks'),
                ],
                onTap: (index) {
                  if (index == 0) {
                    setState(() {
                      _showTopPics = false;
                    });
                  } else if (index == 1) {
                    setState(() {
                      _showTopPics = true;
                    });
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLikedMeWindow() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          const SizedBox(height: 220.0),
          const Text(
            'See people who likes you With Ashiqui Gold',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.0,
              color: Color(0xFFA2A2A2),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 220.0),
          _buildLikedMeButton(),
        ],
      ),
    );
  }

  Widget _buildTopPicksCard({required DiscoverUser userInfo}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFC4C4C4),
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 0.2),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const UserProfileScreen(),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: userInfo.profile_pic != ""
                    ? photoBucket + userInfo.profile_pic.toString()
                    : defaultNoImageUrl,
                fit: BoxFit.cover,
                height: 278.0,
                width: (MediaQuery.of(context).size.width / 2) -
                    (kDefaultPadding / 1.5),
              ),
            ),
          ),
          Positioned(
            left: 12.0,
            bottom: 8.0,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          userInfo.name != ""
                              ? Helper().getFirstWord(userInfo.name)
                              : "Jhon",
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
                          "19",
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
                          'Recently active',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPicksWindow() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently Active',
                style: TextStyle(
                  color: Color(0xFF474747),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RawMaterialButton(
                padding: const EdgeInsets.all(0),
                splashColor: const Color(0xFFEAEAEC),
                fillColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Color(0xFFFFFFFF)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const <Widget>[
                    Text(
                      'SEE MORE',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecentlyActiveScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          children: [
            const SizedBox(width: kDefaultPadding / 2),
            _buildTopPicksCard(userInfo: recentlyActive[0]),
            const SizedBox(width: kDefaultPadding / 2),
            _buildTopPicksCard(userInfo: recentlyActive[1]),
          ],
        ),
        const SizedBox(height: kDefaultPadding * 1.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Common Passion',
                style: TextStyle(
                  color: Color(0xFF474747),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RawMaterialButton(
                padding: const EdgeInsets.all(0),
                splashColor: const Color(0xFFEAEAEC),
                fillColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Color(0xFFFFFFFF)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const <Widget>[
                    Text(
                      'SEE MORE',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CommonPassionScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          children: [
            const SizedBox(width: kDefaultPadding / 2),
            _buildTopPicksCard(userInfo: recomended[1]),
            const SizedBox(width: kDefaultPadding / 2),
            _buildTopPicksCard(userInfo: recomended[0]),
          ],
        ),
        const SizedBox(height: kDefaultPadding * 1.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommended',
                style: TextStyle(
                  color: Color(0xFF474747),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RawMaterialButton(
                padding: const EdgeInsets.all(0),
                splashColor: const Color(0xFFEAEAEC),
                fillColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Color(0xFFFFFFFF)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const <Widget>[
                    Text(
                      'SEE MORE',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecommendScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          children: [
            const SizedBox(width: kDefaultPadding / 2),
            _buildTopPicksCard(userInfo: recomended[0]),
            const SizedBox(width: kDefaultPadding / 2),
            _buildTopPicksCard(userInfo: recomended[1]),
          ],
        ),
      ],
    );
  }

  Widget _buildLikedMeButton() {
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
            padding: EdgeInsets.all(10.0),
            child: Text(
              'See Who Likes You',
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
            builder: (context) => const LikedMeScreen(users: users),
          ),
        );
      },
    );
  }
}
