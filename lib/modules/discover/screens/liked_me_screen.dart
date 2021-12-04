import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:loveria/widgets/discover_app_bar.dart';

class LikedMeScreen extends StatefulWidget {
  final List<User> users;
  const LikedMeScreen({Key? key, required this.users}) : super(key: key);

  @override
  _LikedMeScreenState createState() => _LikedMeScreenState();
}

class _LikedMeScreenState extends State<LikedMeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = (size.width / 2) - kDefaultPadding;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: DiscoverAppBar(headerName: 'Likes'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            children: List.generate(
              widget.users.length,
              (index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const UserProfileScreen(),
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
                        left: 12.0,
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
                            const SizedBox(width: 16.0),
                            Text(
                              users[index].college,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Lato'),
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

  Widget _buildLikedMe() {
    return Container();
  }
}
