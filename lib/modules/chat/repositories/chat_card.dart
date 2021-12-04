import 'package:flutter/material.dart';
import 'package:loveria/models/models.dart';
import 'package:loveria/utils/helpers/constants.dart';

class ChatCard extends StatefulWidget {
  final Chat chat;
  final VoidCallback press;

  const ChatCard({Key? key, required this.chat, required this.press})
      : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(widget.chat.image),
                ),
                if (widget.chat.isActive)
                  Positioned(
                    right: 3,
                    bottom: 3,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEE41A3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chat.name,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        widget.chat.lastMessage,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
