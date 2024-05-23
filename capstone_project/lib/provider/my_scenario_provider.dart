import 'package:flutter/material.dart';

class MyScenarioProvider with ChangeNotifier {
  late int scenarioId;
  late String scenarioMode;

  void setScenarioId(int newScenarioId, String newScenarioMode) {
    scenarioId = newScenarioId;
    scenarioMode= newScenarioMode;
    notifyListeners();
  }

  int getScenarioId() => scenarioId;
  String getScenarioMode() => scenarioMode;
}