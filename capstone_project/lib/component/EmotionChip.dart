import 'package:flutter/material.dart';

class EmotionChip extends StatelessWidget {
  final String emotion;

  EmotionChip(this.emotion);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        EmotionLabel(emotion),
        SizedBox(
          width: 4,
        ),
        EmotionIcon(emotion)
      ],
    );
  }
}

Widget EmotionLabel(String value) {
  if (value == "분노") {
    return Text(
      value,
      style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 172, 0, 0),
          fontWeight: FontWeight.bold),
    );
  } else if (value == "평범") {
    return Text(
      value,
      style: TextStyle(
          fontSize: 12, color: Color(0xffBEBEBE), fontWeight: FontWeight.w700),
    );
  } else if (value == "웃음") {
    return Text(
      value,
      style: TextStyle(
          fontSize: 12, color: Color(0xffFFD700), fontWeight: FontWeight.w700),
    );
  } else if (value == "슬픔") {
    return Text(value,
        style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 65, 105, 225),
            fontWeight: FontWeight.w700));
  } else if (value == "놀라움") {
    return Text(
      value,
      style: TextStyle(
          fontSize: 12, color: Color(0xff32CD32), fontWeight: FontWeight.w700),
    );
  } else if (value == "두려움") {
    return Text(
      value,
      style: TextStyle(
          fontSize: 12, color: Color(0xff8E9A30), fontWeight: FontWeight.w700),
    );
  } else if (value == "강조") {
    return Text(
      value,
      style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 172, 0, 0),
          fontWeight: FontWeight.bold),
    );
  }else {
    return Text("");
  }
}

Widget EmotionIcon(String value) {
  if (value == "평범") {
    return Icon(
      Icons.circle,
      color: Color(0xffBEBEBE),
      size: 16,
    );
  } else if (value == "분노") {
    return Icon(
      Icons.circle,
      color: Color.fromARGB(255, 172, 0, 0),
      size: 16,
    );
  } else if (value == "웃음") {
    return Icon(
      Icons.circle,
      color: Color(0xffFFD700),
      size: 16,
    );
  } else if (value == "슬픔") {
    return Icon(
      Icons.circle,
      color: Color.fromARGB(255, 65, 105, 225),
      size: 16,
    );
  } else if (value == "놀라움") {
    return Icon(
      Icons.circle,
      color: Color(0xff32CD32),
      size: 16,
    );
  } else if (value == "두려움") {
    return Icon(
      Icons.circle,
      color: Color(0xff8E9A30),
      size: 16,
    );
  } else {
    return Text("");
  }
}
