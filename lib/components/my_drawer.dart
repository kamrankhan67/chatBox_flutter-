import 'package:chat_box/services.dart/auth/auth_service.dart';
import 'package:chat_box/pages/setting_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: Icon(
                    Icons.message,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                  title: Text("H O M E"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                  title: Text("S E T T I N G "),
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>SettingPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              title: Text("L O G O U T"),
              onTap: () {
                final auth = AuthService();
                auth.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
