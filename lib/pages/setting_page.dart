import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Theme.of(context).colorScheme.secondary,backgroundColor: Theme.of(context).colorScheme.primary,title: Center(child: Text("Settings",)),),
    );
  }
}