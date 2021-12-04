import 'package:flutter/material.dart';
import 'package:loveria/utils/helpers/constants.dart';

class DefaultAppBar extends StatefulWidget {
  const DefaultAppBar({Key? key, required this.headerName}) : super(key: key);

  final String headerName;

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
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
