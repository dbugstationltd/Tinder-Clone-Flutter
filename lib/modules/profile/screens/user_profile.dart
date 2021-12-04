import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loveria/api/api.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/styles.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _showVideos = false;

  var userProfile;

  @override
  void initState() {
    Helper().checkLoggedInUser(context);
    _getInterestList();
    super.initState();
  }

  Future _getInterestList() async {
    bool internetConnected = await CheckInternet().checkInternet();

    if (internetConnected != true) {
      return ToastMaker().simpleErrorToast('Check your internet connection.');
    }
    FocusScope.of(context).requestFocus(FocusNode());

    try {
      Response response = await CallApi().getData('/personProfile/6');
      Map responseBody = response.data;
      if (responseBody['success'] != null) {
        if (responseBody['success'] == true) {
          userProfile = responseBody['user'];
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
      ToastMaker().simpleErrorToast(defaultErrorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _buildBody(),
          _buildMediaTabBar(),
          _buildMediaBox(),
        ],
      ),
    );
  }

  Widget _buildIndicator() => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: MediaQuery.of(context).padding.top + kDefaultPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIndicatorIcon(true),
            _buildIndicatorIcon(false),
            _buildIndicatorIcon(false),
            _buildIndicatorIcon(false),
            _buildIndicatorIcon(false),
          ],
        ),
      );

  Widget _buildIndicatorIcon(bool currentImage) => Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          height: 9,
          width: 9,
          decoration: BoxDecoration(
            color: currentImage ? kPrimaryTextColor : kSecondaryTextColor,
            shape: BoxShape.circle,
          ),
        ),
      );

  SliverToBoxAdapter _buildBody() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
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
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: users[0].profileImageUrl,
                    useOldImageOnUrlChange: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      iconSize: 30.0,
                      color: kSecondaryTextColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              _buildIndicator(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Jessica',
                      style: TextStyle(
                        fontSize: 36.0,
                        color: Color(0xFF474747),
                      ),
                    ),
                    const SizedBox(width: 22.0),
                    const Text(
                      '22',
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    _buildFollowButton(),
                  ],
                ),
                const SizedBox(height: 18.0),
                Row(
                  children: const [
                    Icon(
                      FontAwesomeIcons.graduationCap,
                      color: Color(0xFFA2A2A2),
                      size: 18.0,
                    ),
                    SizedBox(width: kDefaultPadding / 2),
                    Text(
                      'IBA, University of Dhaka',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                        color: Color(0xFF474747),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
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
                const Divider(color: Color(0xFFA2A2A2)),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
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
                const SizedBox(height: kDefaultPadding),
                Row(
                  children: const [
                    Flexible(
                      child: Text(
                        'Amet minim mollit non deserunt ullamco est sit aliqua dolor done amet sint. Velit officia consequat duis  consequat duis enim velit mollit.',
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
                const SizedBox(height: kDefaultPadding / 2),
                const Divider(color: Color(0xFFA2A2A2)),
                const SizedBox(height: kDefaultPadding * 1.5),
                Row(
                  children: const [
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
                const SizedBox(height: 10),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 4.0,
                  runSpacing: 4,
                  children: [
                    _buildPassion("Music", true),
                    _buildPassion('Sports', true),
                    _buildPassion('Shopping', false),
                    _buildPassion('Games', false),
                    _buildPassion('Travel', false),
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

  SliverToBoxAdapter _buildMediaBox() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!_showVideos) _buildPhotosWindow(),
              if (_showVideos) _buildVideosWindow()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotosWindow() {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 1.3,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: (MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.width),
        children: List.generate(
          profile.media.length,
          (index) => Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: profile.media[index],
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
