import 'package:flutter/material.dart';
import 'package:loveria/utils/helpers/constants.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(
              Icons.image,
              color: kSuccessColor,
            ),
            const SizedBox(width: kDefaultPadding / 3),
            const Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: kSuccessColor,
            ),
            const SizedBox(width: kDefaultPadding - 5),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 0.75),
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
                          hintText: "Write your message...",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xFFA2A2A2),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'SEND',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
