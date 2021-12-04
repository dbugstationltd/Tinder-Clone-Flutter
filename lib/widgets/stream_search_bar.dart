import 'package:flutter/material.dart';
import 'package:loveria/utils/helpers/constants.dart';

class StreamSearchBar extends StatefulWidget {
  const StreamSearchBar({Key? key}) : super(key: key);

  @override
  _StreamSearchBarState createState() => _StreamSearchBarState();
}

class _StreamSearchBarState extends State<StreamSearchBar> {
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
      centerTitle: true,
      title: Container(
        padding: const EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: const Color(0xFFD1D1D1)),
        ),
        child: Row(
          children: const [
            SizedBox(width: kDefaultPadding / 4),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Here",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color(0xFFA2A2A2),
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFABABAC),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: const [
        SizedBox(width: 30.0),
      ],
    );
  }
}
