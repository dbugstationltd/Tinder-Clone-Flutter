import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/screens/screen.dart';

class StreamAppBar extends StatefulWidget {
  const StreamAppBar({Key? key}) : super(key: key);

  @override
  _StreamAppBarState createState() => _StreamAppBarState();
}

class _StreamAppBarState extends State<StreamAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      // leading: IconButton(
      //   icon: const Icon(
      //     Icons.arrow_back_ios,
      //     color: kSecondaryTextColor,
      //   ),
      //   iconSize: 24.0,
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // ),
      centerTitle: true,
      title: const Text(
        "Streaming",
        style: TextStyle(
          color: kSecondaryTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          fontFamily: 'Roboto',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: kSecondaryTextColor,
          ),
          iconSize: 24.0,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const StramSearchScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
