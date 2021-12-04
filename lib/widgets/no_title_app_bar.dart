import 'package:flutter/material.dart';
import 'package:loveria/utils/helpers/constants.dart';

class NoTitleAppBar extends StatelessWidget {
  const NoTitleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: kSecondaryTextColor,
        ),
        iconSize: 24.0,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
