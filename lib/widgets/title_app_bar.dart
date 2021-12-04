import 'package:flutter/material.dart';
import 'package:loveria/utils/helpers/constants.dart';

class TitleAppBar extends StatefulWidget {
  final String headerName;
  final double elevation;

  const TitleAppBar({Key? key, required this.headerName, required this.elevation}) : super(key: key);

  @override
  _TitleAppBarState createState() => _TitleAppBarState();
}

class _TitleAppBarState extends State<TitleAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: widget.elevation,
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
      centerTitle: true,
      title: Text(
        widget.headerName,
        style: const TextStyle(
          color: kSecondaryTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
