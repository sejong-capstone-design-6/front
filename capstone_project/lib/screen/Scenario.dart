import 'package:capstone_project/services/api_service.dart';
import 'package:flutter/material.dart';

class Scenario extends StatefulWidget {
  const Scenario({super.key});

  @override
  State<Scenario> createState() => _ScenarioState();
}

class _ScenarioState extends State<Scenario> {
  String text = '';
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Capstone Speech',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              text = _controller.text;
              ApiService().postContent(text);
              print('완료 clicked');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.center,
              child: Text(
                '완료',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
                controller: _controller,
                style: TextStyle(
                  height: 2.0,
                  color: Colors.amber,
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
