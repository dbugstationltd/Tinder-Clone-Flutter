import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/modules/search/provider/card_provider.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/enums.dart';
import 'package:loveria/utils/helpers/helpers.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';
import 'package:provider/provider.dart';

class SwipeCard extends StatefulWidget {
  final bool isFront;
  final SwipeUser swipeUser;

  const SwipeCard({Key? key, required this.isFront, required this.swipeUser})
      : super(key: key);

  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  String _image = defaultNoImageUrl;
  String get image => _image;

  @override
  void initState() {
    checkImageUrl();
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  void checkImageUrl() async {
    String image = await Helper()
        .getLastThreeImageUrl(widget.swipeUser.userPhotoLastThree);
    setState(() {
      _image = image;
    });
    print(_image);
  }

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: widget.isFront ? _buildFrontCard() : _buildCard(),
      );

  Widget _buildFrontCard() => GestureDetector(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final provider = Provider.of<CardProvider>(context);
            final position = provider.position;
            final milliseconds = provider.isDragging ? 0 : 400;

            final center = constraints.smallest.center(Offset.zero);
            final angle = provider.angle * pi / 180;
            final rotateMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: milliseconds),
                transform: rotateMatrix..translate(position.dx, position.dy),
                child: Stack(
                  children: [
                    _buildCard(),
                    _buildStamps(),
                  ],
                ));
          },
        ),
        onPanStart: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.endPosition();
        },
      );

  Widget _buildCard() => ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
              alignment: const Alignment(-0.3, 0.0),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(),
            child: Container(
              decoration: const BoxDecoration(gradient: kGradientCardStyle),
              padding: const EdgeInsets.fromLTRB(
                kDefaultPadding,
                kDefaultPadding,
                kDefaultPadding,
                kDefaultPadding * 4.5,
              ),
              child: Column(
                children: [
                  _buildIndicator(),
                  const Spacer(),
                  _buildName(),
                  const SizedBox(height: kDefaultPadding / 2),
                  _buildStatus(),
                  const SizedBox(height: kDefaultPadding / 2),
                  _buildPassions(),
                  const SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildIndicator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIndicatorIcon(true),
          _buildIndicatorIcon(false),
          _buildIndicatorIcon(false),
          _buildIndicatorIcon(false),
          _buildIndicatorIcon(false),
        ],
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

  Widget _buildName() => Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(
                    userId: widget.swipeUser.id,
                  ),
                ),
              );
            },
            child: Text(
              Helper().getNameFirstWord(widget.swipeUser.name),
              style: const TextStyle(
                color: kPrimaryTextColor,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 36.0,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          Text(
            Helper().checkNullString(widget.swipeUser.birthdate.toString()),
            style: const TextStyle(
              color: kPrimaryTextColor,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 30.0,
            ),
          ),
          const SizedBox(width: 15.0),
          _buildPassionWithIconButton('Follow'),
        ],
      );

  Widget _buildStatus() => Row(
        children: [
          Container(
            height: 11,
            width: 11,
            decoration: const BoxDecoration(
              color: Color(0xFF09F6A0),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8.0),
          const Text(
            'Recently active',
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: 'Lato'),
          ),
        ],
      );

  Widget _buildPassions() => Wrap(
        direction: Axis.horizontal,
        spacing: 0.0,
        runSpacing: 4,
        children: [
          _buildPassionWithIconButton('Netflix'),
          const SizedBox(width: kDefaultPadding / 2),
          _buildPassionWithIconButton('Vloging'),
          const SizedBox(width: kDefaultPadding / 2),
          _buildPassionNoIconButton('Shopping'),
          const SizedBox(width: kDefaultPadding / 2),
          _buildPassionNoIconButton('Foodie'),
          const SizedBox(width: kDefaultPadding / 2),
          _buildPassionNoIconButton('Travel'),
        ],
      );

  Widget _buildPassionWithIconButton(String passion) => FittedBox(
        child: Container(
          constraints: const BoxConstraints(),
          decoration: const BoxDecoration(
            gradient: kGradientButtonStyle,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: Row(
              children: [
                const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 24.0,
                ),
                const SizedBox(
                  width: 2.0,
                ),
                Text(
                  passion,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
      );

  Widget _buildPassionNoIconButton(String passion) => FittedBox(
        child: Container(
          constraints: const BoxConstraints(),
          decoration: const BoxDecoration(
            gradient: kGradientBlackButtonStyle,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
            child: Text(
              passion,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  Widget _buildStamps() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus();
    final opacity = provider.getStatusOpacity();

    switch (status) {
      case CardStatus.like:
        final child = buildStamp(
          angle: -0.5,
          color: Colors.green,
          text: "LIKE",
          opacity: opacity,
        );
        return Positioned(top: 64, left: 50, child: child);

      case CardStatus.dislike:
        final child = buildStamp(
          angle: 0.5,
          color: Colors.red,
          text: "NOPE",
          opacity: opacity,
        );
        return Positioned(top: 64, right: 50, child: child);

      case CardStatus.superLike:
        final child = buildStamp(
          angle: -0.5,
          color: Colors.blue,
          text: "SUPER\nLIKE",
          opacity: opacity,
        );
        return Positioned(
            bottom: 188,
            left: MediaQuery.of(context).size.width / 4,
            child: child);

      default:
        return Container();
    }
  }

  Widget buildStamp({
    double angle = 0,
    required Color color,
    required String text,
    required double opacity,
  }) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 4),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
