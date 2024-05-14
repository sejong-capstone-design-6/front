  import 'package:flutter/material.dart';

Widget ProposedEmotionLabel(String emotion) {
    Color color = Colors.white;
    if (emotion == "평범") {
      color = Color(0xff6A5ACD);
    } else if (emotion == "분노") {
      color = Color.fromARGB(255, 172, 0, 0);
    } else if (emotion == "웃음") {
      color = Color(0xffFFD700);
    } else if (emotion == "슬픔") {
      color = Color.fromARGB(255, 65, 105, 225);
    } else if (emotion == "놀라움") {
      color = Color(0xff32CD32);
    } else if (emotion == "두려움") {
      color = Color(0xff8E9A30);
    } else {
      color = Colors.white;
    }
    return Text(
      '$emotion',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: color),
    );
  }