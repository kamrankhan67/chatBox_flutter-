import 'package:chat_box/components/chat_bubble.dart';
import 'package:chat_box/components/my_textfield.dart';
import 'package:chat_box/services.dart/auth/auth_service.dart';
import 'package:chat_box/services.dart/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.recieverEmail,
    required this.recieverID,
  });
  final String recieverEmail;
  final String recieverID;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final AuthService _authService = AuthService();

  final ChatServices _chatServices = ChatServices();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
    _messageController.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
        widget.recieverID,
        _messageController.text,
      );
      _messageController.clear();
      scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
        title: Text(widget.recieverEmail),
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Padding(
        padding: EdgeInsets.only(bottom: 20),
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
                    focusNode: myFocusNode,
                    controller: _messageController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 98, 157, 99),
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
      stream: _chatServices.getMessage(widget.recieverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading ...");
        }
        return ListView(
          controller: _scrollController,
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
      child: ChatBubble(isCurrentUser: isCurrentUser, message: data['message']),
    );
  }
}
