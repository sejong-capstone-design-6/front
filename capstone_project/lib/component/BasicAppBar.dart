import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget {
  final String title;
  BasicAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.white,
        icon: Icon(Icons.keyboard_arrow_left),
        iconSize: 24,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      centerTitle: true,
      titleSpacing: 6.5,
    );
  }
}