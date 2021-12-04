import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/modules/chat/repositories/chat_card.dart';
import 'package:loveria/utils/screens/screen.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key}) : super(key: key);

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: chatsData.length,
        itemBuilder: (context, index) => ChatCard(
          chat: chatsData[index],
          press: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => MessageScreen(chats: chatsData[index]),
            ),
          ),
        ),
      ),
    );
  }
}
