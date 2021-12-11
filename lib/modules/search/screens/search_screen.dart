import 'package:flutter/material.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/modules/search/provider/card_provider.dart';
import 'package:loveria/modules/search/repositories/swipe_card.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:loveria/utils/services/services.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CardProvider(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SearchScreenMain(),
        ),
      );
}

class SearchScreenMain extends StatefulWidget {
  const SearchScreenMain({Key? key}) : super(key: key);

  @override
  _SearchScreenMainState createState() => _SearchScreenMainState();
}

class _SearchScreenMainState extends State<SearchScreenMain> {
  final liked = LikedDao();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: CustomAppBar(),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 160,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(kDefaultPadding),
                child: buildCards(),
              ),
              _buildButtons(),
            ],
          ),
        ),
      );

  void _sendLike() {
    final like = Liked(2, 1, DateTime.now());
    liked.saveLikes(like);
    setState(() {});
  }

  Widget _buildButtons() {
    final provider = Provider.of<CardProvider>(context);
    final swipeUsers = provider.swipeUsers;
    final status = provider.getStatus();
    final isLike = status == CardStatus.like;
    final isDislike = status == CardStatus.dislike;
    final isSuperLike = status == CardStatus.superLike;

    return swipeUsers.isEmpty
        ? SizedBox()
        : Positioned(
            bottom: kDefaultPadding * 2,
            left: kDefaultPadding * 2,
            right: kDefaultPadding * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionWindow(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        width: 1,
                        color: Color(0xFFFABF1B),
                      ),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.replay_rounded,
                      color: Color(0xFFFABF1B),
                      size: 28.0,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    final provider =
                        Provider.of<CardProvider>(context, listen: false);
                    provider.dislike();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDislike ? Color(0xFFF74884) : Colors.transparent,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFF74884),
                      ),
                    ),
                    padding: const EdgeInsets.all(14.0),
                    child: Icon(
                      Icons.close_rounded,
                      color: isDislike ? kPrimaryTextColor : Color(0xFFF74884),
                      size: 28.0,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    final provider =
                        Provider.of<CardProvider>(context, listen: false);
                    provider.superLike();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isSuperLike ? Color(0xFF77D9FA) : Colors.transparent,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFF77D9FA),
                      ),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.star_rounded,
                      color:
                          isSuperLike ? kPrimaryTextColor : Color(0xFF77D9FA),
                      size: 28.0,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    final provider =
                        Provider.of<CardProvider>(context, listen: false);
                    provider.like();
                    _sendLike();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isLike ? Color(0xFF05FFAF) : Colors.transparent,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFF05FFAF),
                      ),
                    ),
                    padding: const EdgeInsets.all(14.0),
                    child: Icon(
                      Icons.favorite_rounded,
                      color: isLike ? kPrimaryTextColor : Color(0xFF05FFAF),
                      size: 28.0,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionWindow(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFB781F3),
                      ),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: const Icon(
                      Icons.bolt,
                      color: Color(0xFFB781F3),
                      size: 28.0,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    // final urlImages = provider.urlImages;
    final swipeUsers = provider.swipeUsers;

    return swipeUsers.isEmpty
        ? Center(
            child: RawMaterialButton(
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
                    maxWidth: 120.0,
                    maxHeight: 46.0,
                  ),
                  alignment: Alignment.center,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Restart',
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
                final provider =
                    Provider.of<CardProvider>(context, listen: false);
                provider.resetSwipeCards();
              },
            ),
          )
        : Stack(
            children: swipeUsers
                .map(
                  (swipeUser) => SwipeCard(
                    isFront: swipeUsers.last == swipeUser,
                    swipeUser: swipeUser,
                  ),
                )
                .toList(),
          );
  }
}
