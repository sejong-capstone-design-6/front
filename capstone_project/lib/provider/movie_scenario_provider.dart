import 'package:flutter/material.dart';

class MovieScenarioProvider with ChangeNotifier {
  late int scenarioId;
  late String title;
  late String url;

  void setScenarioId(int newScenarioId) {
    scenarioId = newScenarioId;
    notifyListeners();
  }

  int getScenarioId() => scenarioId;

  void setTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  String getTitle() => title;

  String getUrl() => url;
  void SetUrl(String newUrl) {
    url = newUrl;
    notifyListeners();
  }
}
