import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),

        // alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: PrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class ChatBubbleRight extends StatelessWidget {
  ChatBubbleRight({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),

        // alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          // color: Color(0xff006D84),
          color: const Color(0xFF2563EB),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
