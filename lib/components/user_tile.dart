import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const  UserTile({super.key,required this.onTap,required this.text});
  final String text;
   final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.secondary,
          
        ),
        child: Row(
          
          children: [
            Icon(Icons.person),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(text),
            )
          ],
        ),
      ),
    );
  }
}
