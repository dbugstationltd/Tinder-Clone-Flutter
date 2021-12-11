import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/config/routes/routing_constants.dart';
import 'package:loveria/modules/chat/models/chat.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';

class LiveStreamScreen extends StatefulWidget {
  const LiveStreamScreen({Key? key}) : super(key: key);

  @override
  _LiveStreamScreenState createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(streamBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: kGradientCardStyle,
          ),
          child: Stack(
            children: [
              Positioned(
                top: topPadding + 16,
                left: kDefaultPadding,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: CachedNetworkImage(
                    imageUrl: users[0].profileImageUrl,
                    fit: BoxFit.cover,
                    height: 40.0,
                    width: 40,
                  ),
                ),
              ),
              Positioned(
                top: topPadding + 48,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                    vertical: kDefaultPadding / 4.5,
                  ),
                  decoration: BoxDecoration(
                    gradient: kGradientLiveStyle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "LIVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 11.0,
                      // letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: topPadding + 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 48),
                      Column(
                        children: [
                          const Text(
                            "Khan Akira",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              color: kPrimaryTextColor,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.visibility,
                                size: 16,
                                color: kPrimaryTextColor,
                              ),
                              SizedBox(width: 6.3),
                              Text(
                                "457",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                  color: kPrimaryTextColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: kDefaultPadding),
                      InkWell(
                        onTap: _handFollowModal,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: kGradientLiveStyle,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 24,
                            color: kPrimaryTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: topPadding + 17,
                right: 12,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: kPrimaryColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(80.0),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CachedNetworkImage(
                          imageUrl: users[1].profileImageUrl,
                          fit: BoxFit.cover,
                          height: 27.0,
                          width: 27,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: kPrimaryColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(80.0),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CachedNetworkImage(
                          imageUrl: users[2].profileImageUrl,
                          fit: BoxFit.cover,
                          height: 27.0,
                          width: 27,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: kPrimaryColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(80.0),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CachedNetworkImage(
                          imageUrl: users[3].profileImageUrl,
                          fit: BoxFit.cover,
                          height: 27.0,
                          width: 27,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: kPrimaryColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(80.0),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CachedNetworkImage(
                          imageUrl: users[4].profileImageUrl,
                          fit: BoxFit.cover,
                          height: 27.0,
                          width: 27,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 24,
                          color: kPrimaryTextColor,
                        ),
                      ),
                      onTap: _onClosePressed,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CachedNetworkImage(
                            imageUrl: users[2].profileImageUrl,
                            fit: BoxFit.cover,
                            height: 40.0,
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Tristian Do",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                color: Color(0xFFFCCF46),
                              ),
                            ),
                            Text(
                              "Donated",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                color: kPrimaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CachedNetworkImage(
                            imageUrl: users[3].profileImageUrl,
                            fit: BoxFit.cover,
                            height: 40.0,
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Jackson Ruice",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                color: Color(0xFFFCCF46),
                              ),
                            ),
                            Text(
                              "Your eyes very nice",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                color: kPrimaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CachedNetworkImage(
                            imageUrl: users[4].profileImageUrl,
                            fit: BoxFit.cover,
                            height: 40.0,
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Ruice Jackson",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                color: Color(0xFFFCCF46),
                              ),
                            ),
                            Text(
                              "You look gourgeous",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                color: kPrimaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 21),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "Say Something...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                              ),
                              suffixIcon: Icon(
                                Icons.send,
                                size: 20,
                                color: kPrimaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 52.0,
                          height: 52.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Image(
                            image: AssetImage('assets/icons/diamond.png'),
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 52.0,
                          height: 52.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Image(
                            image: AssetImage('assets/icons/like.png'),
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 52.0,
                          height: 52.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Image(
                            image: AssetImage('assets/icons/share.png'),
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handFollowModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext buildContext) {
        return Container(
          height: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 76,
                    height: 76,
                    imageUrl: users[0].profileImageUrl,
                    useOldImageOnUrlChange: true,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Khan Akira',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 26.0,
                          color: Color(0xFF474747),
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: kDefaultPadding / 1.5),
                    Container(
                      decoration: BoxDecoration(
                        gradient: kGradientChatIconStyle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.done,
                        size: 20,
                        color: kPrimaryTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActivityOption('75k', 'Following'),
                    const SizedBox(width: 22.0),
                    _buildActivityOption('155k', 'Follower'),
                    const SizedBox(width: 16.0),
                    _buildActivityOption('1.2M', 'Likes'),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFollowButton(),
                    _buildChatButton(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      Navigator.of(context).pushNamedAndRemoveUntil(
          bottomNavRoute, (Route<dynamic> route) => false);
    });
  }

  Widget _buildActivityOption(String count, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Color(0xFF474747),
            fontSize: 22,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          type,
          style: const TextStyle(
            color: Color(0xFF474747),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildChatButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 0.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: kSecondaryColor),
      ),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 140.0,
          minHeight: 36.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: const <Widget>[
              Text(
                'Chat',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18.0,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MessageScreen(
              chats: chatsData[0],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFollowButton() {
    return RawMaterialButton(
      splashColor: const Color(0xFFEAEAEC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 140.0,
          minHeight: 36.0,
        ), // min sizes for Material buttons
        decoration: const BoxDecoration(
          gradient: kGradientButtonStyle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: const [
              Icon(
                Icons.add,
                color: kPrimaryTextColor,
                size: 24,
              ),
              SizedBox(width: 8.0),
              Text(
                'Follow',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => UserProfileScreen(userId: 92,),
          ),
        );
      },
    );
  }

  void _onClosePressed() {
    showDialog(
      context: context,
      builder: (context) => SaveSteamDialog(
        message: 'Do you want to save?',
        confirmTask: () {},
      ),
    );
  }
}
