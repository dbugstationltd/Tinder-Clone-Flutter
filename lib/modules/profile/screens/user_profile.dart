import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/styles.dart';

class UserProfileScreen extends StatefulWidget {
  final int userId;
  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _showVideos = false;
  late Future<Map<String, dynamic>> profileUser;

  var userProfile;

  @override
  void initState() {
    super.initState();
    Helper().checkLoggedInUser(context);
    profileUser = fetchUser();
  }

  Future<Map<String, dynamic>> fetchUser() async {
    Response response = await CallApi()
        .getData(personProfileRoute + '/' + widget.userId.toString());
    Map<String, dynamic> responseBody = response.data;
    if (responseBody['success'] != null) {
      if (responseBody['success'] == true) {
        return responseBody['data'];
      } else {
        throw Exception('Failed to load album');
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: profileUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  _buildBody(snapshot),
                  _buildMediaTabBar(),
                  _buildMediaBox(snapshot),
                ],
              );
              // return Text(snapshot.data!['name']);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildIndicator(List img) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: MediaQuery.of(context).padding.top + kDefaultPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i in img)
              i == 0 ? _buildIndicatorIcon(true) : _buildIndicatorIcon(false),
          ],
        ),
      );

  Widget _buildIndicatorIcon(bool currentImage) => Padding(
        padding: EdgeInsets.all(4),
        child: Container(
          height: 9,
          width: 9,
          decoration: BoxDecoration(
            color: currentImage ? kPrimaryTextColor : kSecondaryTextColor,
            shape: BoxShape.circle,
          ),
        ),
      );

  SliverToBoxAdapter _buildBody(AsyncSnapshot snapshot) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: Helper().getLastThreeImageUrl(
                        snapshot.data['userPhotoLastThree']),
                    useOldImageOnUrlChange: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded),
                      iconSize: 30.0,
                      color: kSecondaryTextColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              _buildIndicator(snapshot.data['userPhotoLastThree']),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      Helper().getNameFirstWord(snapshot.data['name']),
                      style: TextStyle(
                        fontSize: 36.0,
                        color: Color(0xFF474747),
                      ),
                    ),
                    SizedBox(width: 22.0),
                    Text(
                      snapshot.data['birthdate'].toString(),
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    _buildFollowButton(),
                  ],
                ),
                SizedBox(height: 18.0),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.graduationCap,
                      color: Color(0xFFA2A2A2),
                      size: 18.0,
                    ),
                    SizedBox(width: kDefaultPadding / 2),
                    Text(
                      Helper().checkNullString(snapshot.data['school']),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: Color(0xFFA2A2A2),
                      size: 18.0,
                    ),
                    SizedBox(width: kDefaultPadding / 2),
                    Text(
                      '24 km away',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Divider(color: Color(0xFFA2A2A2)),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        Helper().checkNullString(snapshot.data['aboutMe']),
                        maxLines: 5,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Roboto',
                          color: Color(0xFF474747),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding / 2),
                Divider(color: Color(0xFFA2A2A2)),
                SizedBox(height: kDefaultPadding * 1.5),
                Row(
                  children: [
                    Text(
                      'Passions',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 4.0,
                  runSpacing: 4,
                  children: [
                    for (var i in snapshot.data['interests'])
                      _buildPassion(i['interestName'], false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildMediaTabBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 4),
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
                  Text('Photos'),
                  Text('Videos'),
                ],
                onTap: (index) {
                  if (index == 0) {
                    setState(() {
                      _showVideos = false;
                    });
                  } else if (index == 1) {
                    setState(() {
                      _showVideos = true;
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

  SliverToBoxAdapter _buildMediaBox(AsyncSnapshot snapshot) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!_showVideos) _buildPhotosWindow(snapshot.data['photos']),
              if (_showVideos) _buildVideosWindow()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotosWindow(List photos) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 1.3,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: (MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.width),
        children: List.generate(
          photos.length,
          (index) => Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: Helper().getImageUrl(photos[index]['imageUrl']),
                fit: BoxFit.cover,
                height: (MediaQuery.of(context).size.width / 3) -
                    (kDefaultPadding * 3),
                width: (MediaQuery.of(context).size.width / 3) -
                    (kDefaultPadding * 3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPassion(String passion, bool selected) => FittedBox(
        child: Container(
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEE41A3) : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 1,
              color: const Color(0xFFEE41A3),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          child: Text(
            passion,
            style: TextStyle(
              fontSize: 15.0,
              color: selected ? kPrimaryTextColor : kSecondaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

  Widget _buildVideosWindow() {
    return const Text("No videos available!");
  }

  Widget _buildFollowButton() {
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
          constraints: const BoxConstraints(), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Row(
              children: const [
                Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 14.0,
                ),
                SizedBox(
                  width: 2.0,
                ),
                Text(
                  'Follow',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onPressed: () {},
    );
  }
}
