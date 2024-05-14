import 'package:flutter/material.dart';

class ScenarioModel extends StatelessWidget {
  final int id;
  final String title;
  final String sentence;
  final String type;

  ScenarioModel(
      {required this.id,
      required this.title,
      required this.sentence,
      required this.type});

  factory ScenarioModel.fromJson(Map<String, dynamic> json) {
    return ScenarioModel(
      id: json['id'] as int,
      title: json['title'] as String,
      sentence: json['sentence'] as String,
      type: json['type'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
