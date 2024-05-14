import 'package:flutter/material.dart';

class MyScenarioProvider with ChangeNotifier {
  late int scenarioId;

  void setScenarioId(int newScenarioId) {
    scenarioId = newScenarioId;
    notifyListeners();
  }

  int getScenarioId() => scenarioId;
}