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
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyScenarioPage(scenarioId: widget.id)));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            width: 180,
            height: 220,
            decoration: BoxDecoration(
              color: Color(0xff1C1C1E),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (widget.sentence != null)
                        Text(
                          widget.sentence!,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffC4C4C4)),
                        ),
                    ],
                  ),
                  EmotionChip(widget.type)
                ],
              ),
            ),
          ),
        ));
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
