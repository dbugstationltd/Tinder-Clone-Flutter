import 'package:flutter/material.dart';
import 'package:loveria/modules/chat/models/chat_message.dart';
import 'package:loveria/utils/helpers/constants.dart';
import 'package:loveria/utils/helpers/styles.dart';

class TextMessage extends StatelessWidget {
  final ChatMessage message;

  const TextMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: message.isSender
            ? kGradientChatIconStyle
            : kGradientChatTextStyle,
        // color: kPrimaryColor.withOpacity(message.isSender ? 1 : 0.1),
      ),
      child: Text(
        message.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
