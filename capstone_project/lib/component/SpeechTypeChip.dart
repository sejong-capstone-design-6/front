import 'package:flutter/material.dart';

class SpeechTypeChip extends StatelessWidget {
  final String type;

  SpeechTypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpeechTypeIcon(type),
        SizedBox(
          width: 4,
        ),
        SpeechTypeLabel(type)
      ],
    );
  }

  Widget SpeechTypeLabel(String value) {
    if (value == "스피치") {
      return Text(
        value,
        style: TextStyle(
            fontSize: 12,
            color: Color(0xff4169E1),
            fontWeight: FontWeight.bold),
      );
    } else if (value == "연기") {
      return Text(
        value,
        style: TextStyle(
            fontSize: 12, color: Colors.purple, fontWeight: FontWeight.bold),
      );
    } else {
      return Text("");
    }
  }

  Widget SpeechTypeIcon(String value) {
    if (value == "스피치") {
    return Icon(
      Icons.circle,
      color: Color(0xff4169E1),
      size: 16,
    );
  } else if (value == "연기") {
    return Icon(
      Icons.circle,
      color: Colors.purple,
      size: 16,
    );
  } else {
    return Text("");
  }
  }
}
