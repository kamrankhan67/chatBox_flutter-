import 'package:chat_box/components/chat_bubble.dart';
import 'package:chat_box/components/my_textfield.dart';
import 'package:chat_box/services.dart/auth/auth_service.dart';
import 'package:chat_box/services.dart/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.recieverEmail, required this.recieverID});
  final String recieverEmail;
  final String recieverID;
  final TextEditingController _messageController = TextEditingController();
  final AuthService _authService = AuthService();
  final ChatServices _chatServices = ChatServices();
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(recieverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(recieverEmail),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(bottom: 20),
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: MyTextfield(
                    hintText: "Enter a message",
                    obscureText: false,
                    controller: _messageController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 29, 62, 90),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessage(recieverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading ...");
        }
        return ListView(
          children: snapshot.data!.docs
              .map((e) => _buildMessageItem(e))
              .toList(),
        );
      },
    );
  }

Widget _buildMessageItem(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  bool isCurrentUser = data['senderID'] == _authService.getCurentUser()!.uid;

  return Align(
    alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
    child: ChatBubble(
      isCurrentUser: isCurrentUser,
      message: data['message'],
    ),
  );
}

}
