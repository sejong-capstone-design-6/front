import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Scenario extends StatefulWidget {
  const Scenario({super.key});

  @override
  State<Scenario> createState() => _ScenarioState();
}

class _ScenarioState extends State<Scenario> {
  final _contentEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Text(
              'Capstone Speech',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 1000,
              width: 400,
              child: TextField(
                style: TextStyle(
                  height: 2.0,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                maxLines: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
