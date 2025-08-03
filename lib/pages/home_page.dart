import 'package:chat_box/components/my_drawer.dart';
import 'package:chat_box/components/user_tile.dart';
import 'package:chat_box/pages/chat_page.dart';
import 'package:chat_box/services.dart/auth/auth_service.dart';
import 'package:chat_box/services.dart/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  void logOut() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text("Home"),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("ERROR");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading ...");
        }
        final users = snapshot.data as List;
        return ListView(
          children: users
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData['email'] != _authService.getCurentUser()!.email) {
      return UserTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(recieverEmail: userData["email"],recieverID: userData["uid"],),
            ),
          );
        },
        text: userData["email"],
      );
    } else {
      return Container();
    }
  }
}
