import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key,required this.isCurrentUser,required this.message});
  final bool isCurrentUser;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser?Colors.blue:Colors.green,
        borderRadius: BorderRadius.circular(20)
      ),
      child:Text(message),
    );
  }
}
