import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/modules/chat/models/chat.dart';
import 'package:loveria/modules/chat/repositories/chat_body.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';
import 'package:loveria/utils/screens/screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key, required this.chats}) : super(key: key);

  final Chat chats;

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const ChatBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: kSecondaryTextColor,
          size: 24,
        ),
        iconSize: 28.0,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: users[0].profileImageUrl,
              useOldImageOnUrlChange: true,
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          const Text(
            "Flores",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF474747),
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          child: ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (Rect bounds) {
              return kGradientChatIconStyle.createShader(bounds);
            },
            child: const Icon(Icons.videocam, size: 35),
          ),
        ),
        const SizedBox(width: kDefaultPadding / 2),
        ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            return kGradientChatIconStyle.createShader(bounds);
          },
          child: const Icon(Icons.shield),
        ),
        const SizedBox(width: kDefaultPadding),
      ],
    );
  }
}
