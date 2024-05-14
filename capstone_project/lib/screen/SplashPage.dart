import 'dart:async';
import 'package:capstone_project/screen/Login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage())),
    ) //CreateScenarioPage(scenarioId: 4, scenarioID_ID: 3, text: "s", emotion: "평범")
        ;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
          ),
          SizedBox(
            height: 120,
            child: Text(
              "마음의\n       소리",
              style: TextStyle(color: Colors.white, fontSize: 32.0),
            ),
          )
        ],
      ),
    );
  }
}
