import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:loveria/widgets/stream_search_bar.dart';

class StramSearchScreen extends StatefulWidget {
  const StramSearchScreen({Key? key}) : super(key: key);

  @override
  _StramSearchScreenState createState() => _StramSearchScreenState();
}

class _StramSearchScreenState extends State<StramSearchScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = (size.width / 2) - kDefaultPadding;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: StreamSearchBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
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
                    builder: (context) => const LiveStreamScreen(),
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
                        imageUrl: users[index].profileImageUrl,
                        fit: BoxFit.cover,
                        height: 278.0,
                        width: (MediaQuery.of(context).size.width / 2) -
                            (kDefaultPadding / 1.5),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
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
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 2,
                          vertical: kDefaultPadding / 4.5,
                        ),
                        decoration: BoxDecoration(
                          gradient: kGradientBlackButtonStyle,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "229",
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
                      left: 8.0,
                      bottom: 8.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                users[index].name,
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
                                users[index].age,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                ),
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
    );
  }
}
