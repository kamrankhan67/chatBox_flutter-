import 'package:chat_box/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
        title: Center(child: Text("Settings")),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0,left: 20.0,),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:Theme.of(context).colorScheme.tertiary,
            
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dark Mode"),
              CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context,listen:false).isDarkMode,
                onChanged: (value)=>Provider.of<ThemeProvider>(context,listen: false).toggleTheme()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
