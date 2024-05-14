import 'dart:math';

import 'package:flutter/material.dart';

randomEmotion() {
    final emotions = ["평범", "분노", "웃음", "슬픔", "놀라움", "두려움"];
    return emotions[Random().nextInt(6)];
  }

  Widget AIEmotion(String value) {
    Color color = Colors.white;
    if (value == "평범") {
      color = Color(0xff6A5ACD);
    } else if (value == "분노") {
      color = Color.fromARGB(255, 172, 0, 0);
    } else if (value == "웃음") {
      color = Color(0xffFFD700);
    } else if (value == "슬픔") {
      color = Color.fromARGB(255, 65, 105, 225);
    } else if (value == "놀라움") {
      color = Color(0xff32CD32);
    } else if (value == "두려움") {
      color = Color(0xff8E9A30);
    } else {
      color = Colors.white;
    }

    return Row(
      children: [
        Text(
          'AI는 ',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: color),
        ),
        Text(
          '의 감정을 느꼈어요!',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    );
  }

  Widget ComparedSentence(String sentence1, String sentence2) {
    Map<String, Color> comparisonResults =
        compareSentences(sentence1, sentence2);

    List<TextSpan> spans = [];
    sentence1.split(' ').forEach((word) {
      spans.add(
        TextSpan(
          text: '$word ',
          style: TextStyle(
            color: comparisonResults[word],
          ),
        ),
      );
    });

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(fontSize: 16), // 기본 스타일 지정
      ),
    );
  }

  Map<String, Color> compareSentences(String sentence1, String sentence2) {
    List<String> words1 = sentence1.split(' ');
    List<String> words2 = sentence2.split(' ');

    // 같은 단어는 파란색, 다른 단어는 회색으로 표시
    Map<String, Color> wordColors = {};

    for (String word in words1) {
      if (words2.contains(word)) {
        wordColors[word] = Color(0xff4169E1);
      } else {
        wordColors[word] = Color(0xff636367);
      }
    }

    for (String word in words2) {
      if (!wordColors.containsKey(word)) {
        wordColors[word] = Color(0xff636367);
      }
    }

    return wordColors;
  }