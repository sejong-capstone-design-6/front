import 'package:flutter/material.dart';

class TranscriptPageAppBar extends StatelessWidget {
  final String title;
  final String pageRoute;
  TranscriptPageAppBar(this.title, this.pageRoute);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('$pageRoute'));
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