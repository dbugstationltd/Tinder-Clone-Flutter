import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({Key? key}) : super(key: key);

  @override
  _GoLiveScreenState createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryTextColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: kSecondaryTextColor,
            ),
            iconSize: 24.0,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 72,
                    height: 72,
                    imageUrl: profile.profileImageUrl,
                    useOldImageOnUrlChange: true,
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add a title to chat",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryTextColor,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.lock_open,
                          size: 12,
                          color: kSecondaryTextColor,
                        ),
                        SizedBox(
                          width: kDefaultPadding / 3,
                        ),
                        Text(
                          "Public",
                          style: TextStyle(
                            color: kSecondaryTextColor,
                            fontSize: 14.75,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.expand_more,
                          size: 24,
                          color: kSecondaryTextColor,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            _buildGoLiveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoLiveButton() {
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
            maxWidth: 286.0,
            minHeight: 36.0,
          ), // min sizes for Material buttons
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Go Live',
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
          MaterialPageRoute(
            builder: (context) => const LiveStreamScreen(),
          ),
        );
      },
    );
  }
}
