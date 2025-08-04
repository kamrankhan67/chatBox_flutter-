import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isCurrentUser,
    required this.message,
  });
  final bool isCurrentUser;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        
        color: isCurrentUser ? const Color.fromARGB(255, 98, 157, 99) : const Color.fromARGB(255, 88, 93, 96),
        
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(message,style: TextStyle(color: Colors.white),),
    );
  }
}
  