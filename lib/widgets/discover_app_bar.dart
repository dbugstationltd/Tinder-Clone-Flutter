import 'package:flutter/material.dart';
import 'package:loveria/utils/helpers/constants.dart';

class DiscoverAppBar extends StatefulWidget {
  final String headerName;
  const DiscoverAppBar({Key? key, required this.headerName}) : super(key: key);

  @override
  _DiscoverAppBarState createState() => _DiscoverAppBarState();
}

class _DiscoverAppBarState extends State<DiscoverAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: kSecondaryTextColor,
        ),
        iconSize: 28.0,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        widget.headerName,
        style: const TextStyle(
          color: Color(0xFF474747),
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
