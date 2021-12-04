import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loveria/modules/chat/models/chat_message.dart';
import 'package:loveria/modules/chat/repositories/text_message.dart';
import 'package:loveria/utils/data/data.dart';
import 'package:loveria/utils/helpers/constants.dart';

class Message extends StatefulWidget {
  final ChatMessage message;

  const Message({Key? key, required this.message}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        default:
          return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: widget.message.isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!widget.message.isSender) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: CachedNetworkImage(
                imageUrl: users[0].profileImageUrl,
                fit: BoxFit.cover,
                height: 48.0,
                width: 48.0,
              ),
            ),
          ],
          const SizedBox(width: kDefaultPadding / 2),
          messageContaint(widget.message),
          if (widget.message.isSender) ...[
            const SizedBox(width: kDefaultPadding / 2),
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: CachedNetworkImage(
                imageUrl: profile.profileImageUrl,
                fit: BoxFit.cover,
                height: 48.0,
                width: 48.0,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
