import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/modules/chat/models/chat.dart';
import 'package:loveria/modules/profile/models/user_model.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/screens/screen.dart';

class MatchesCarousel extends StatefulWidget {
  const MatchesCarousel({Key? key}) : super(key: key);

  @override
  _MatchesCarouselState createState() => _MatchesCarouselState();
}

class _MatchesCarouselState extends State<MatchesCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "New Matches",
              style: TextStyle(
                color: Color(0xFFEE41A3),
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Container(
              padding: const EdgeInsets.all(2.0),
              decoration: const BoxDecoration(
                color: Color(0xFFEE41A3),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: const Text(
                "48",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        SizedBox(
          height: 145.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              User user = users[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const MatchScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  width: 80,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: CachedNetworkImage(
                          imageUrl: users[index].profileImageUrl,
                          fit: BoxFit.cover,
                          height: 114.46,
                          width: 80.0,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
