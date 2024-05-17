import 'package:capstone_project/screen/Scenario.dart';
import 'package:flutter/material.dart';

class ScenarioModel extends StatelessWidget {
  final int id;
  final String title;
  final String type;

  const ScenarioModel({
    super.key,
    required this.id,
    required this.title,
    required this.type,
  });

  factory ScenarioModel.fromJson(Map<String, dynamic> json) {
    return ScenarioModel(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.withOpacity(0.2),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
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
