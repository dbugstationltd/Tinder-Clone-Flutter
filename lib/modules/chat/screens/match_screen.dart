import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/modules/chat/models/chat.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: NoTitleAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Congratulations",
              style: TextStyle(
                color: kSecondaryTextColor,
                fontSize: 34,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: kDefaultPadding / 4),
            const Text(
              "It’s a Match!",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 38,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: kDefaultPadding * 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: kGradientPageStyle,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: CachedNetworkImage(
                        imageUrl: profile.profileImageUrl,
                        fit: BoxFit.cover,
                        height: 113,
                        width: 113,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: kGradientPageStyle,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: CachedNetworkImage(
                        imageUrl: users[0].profileImageUrl,
                        fit: BoxFit.cover,
                        height: 113,
                        width: 113,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Freida",
                  style: TextStyle(
                    color: kSecondaryTextColor,
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 6.0),
                Text(
                  "19",
                  style: TextStyle(
                    color: kSecondaryTextColor,
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding * 3.5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 3),
              child: Text(
                "You and Freida liked each other, Lets ask her something interesting",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA2A2A2),
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding * 8),
            _buildSendMessageButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSendMessageButton(BuildContext context) {
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
            maxWidth: 300.0,
            minHeight: 36.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Send Message'.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
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
        {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>  MessageScreen(chats: chatsData[1],),
            ),
          );
        }
      },
    );
  }
}
