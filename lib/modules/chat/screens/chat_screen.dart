import 'package:flutter/material.dart';
import 'package:loveria/modules/chat/repositories/chat_box.dart';
import 'package:loveria/modules/chat/repositories/matches_carousel.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/widgets/default_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController matchesSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: DefaultAppBar(headerName: 'Message'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 0.75),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD1D1D1)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.search,
                        color: Color(0xFFEE41A3),
                      ),
                      SizedBox(width: kDefaultPadding / 4),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search 250 matches",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 1.5),
                const MatchesCarousel(),
                const SizedBox(height: kDefaultPadding * 1.5),
                Row(
                  children: [
                    const Text(
                      "Messages",
                      style: TextStyle(
                        color: Color(0xFFEE41A3),
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEE41A3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "89",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                const ChatBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
