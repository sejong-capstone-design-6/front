import 'package:capstone_project/component/EmotionChip.dart';
import 'package:capstone_project/screen/MyScenarioPage.dart';
import 'package:flutter/material.dart';

class ScenarioModel extends StatefulWidget {
  final int id;
  final String title;
  final String? sentence;
  final String type;

  const ScenarioModel({
    super.key,
    required this.id,
    required this.title,
    this.sentence,
    required this.type,
  });

  factory ScenarioModel.fromJson(Map<String, dynamic> json) {
    return ScenarioModel(
      id: json['id'] as int,
      title: json['title'] as String,
      sentence: json['sentence'] as String?,
      type: json['type'] as String,
    );
  }

  @override
  State<ScenarioModel> createState() => _ScenarioModelState();
}

class _ScenarioModelState extends State<ScenarioModel> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.withOpacity(0.2),
      child: ListTile(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.sentence != null) Text(widget.sentence!),
            EmotionChip(widget.type)
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyScenarioPage(scenarioId: widget.id)));
        },
      ),
    );
  }
}

class ScenarioList {
  final List<ScenarioModel> scenarios;

  ScenarioList({required this.scenarios});

  factory ScenarioList.fromJson(Map<String, dynamic> json) {
    var list = json['scenarios'] as List;
    List<ScenarioModel> scenariosList =
        list.map((i) => ScenarioModel.fromJson(i)).toList();
    return ScenarioList(scenarios: scenariosList);
  }
}
