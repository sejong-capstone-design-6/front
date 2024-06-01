import 'package:flutter/material.dart';

class MyScenarioProvider with ChangeNotifier {
  late int scenarioId;
  late String mode;

  void setScenarioId(int newScenarioId) {
    scenarioId = newScenarioId;
    notifyListeners();
  }

  int getScenarioId() => scenarioId;

  void setMode(String newMode) {
    mode = newMode;
    notifyListeners();
  }

  String getMode() => mode;
}