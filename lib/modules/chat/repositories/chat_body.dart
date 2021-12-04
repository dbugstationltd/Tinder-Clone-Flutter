import 'package:flutter/material.dart';
import 'package:loveria/modules/chat/models/chat_message.dart';
import 'package:loveria/modules/chat/repositories/chat_input_field.dart';
import 'package:loveria/modules/chat/repositories/message.dart';
import 'package:loveria/utils/helpers/constants.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    List _demoChatMessages = demoChatMessages.reversed.toList();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                reverse: true,
                itemCount: demoChatMessages.length,
                itemBuilder: (context, index) => Message(
                  message: _demoChatMessages[index],
                ),
              ),
            ),
          ),
          const ChatInputField(),
        ],
      ),
    );
  }
}
