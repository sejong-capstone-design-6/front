import 'package:flutter/material.dart';

class ScenarioCard extends StatefulWidget {
  final String title;
  final String content;
  const ScenarioCard({required this.title, required this.content}) : super();
  @override
  State<ScenarioCard> createState() => _ScenarioCardState();
}

class _ScenarioCardState extends State<ScenarioCard> {
  void onClicked() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: 180,
        height: 200,
        child: Column(
          children: [
            Text(
              'title',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            Text(
              'content',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w100,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
