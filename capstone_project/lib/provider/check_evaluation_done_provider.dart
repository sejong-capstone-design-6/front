import 'package:flutter/material.dart';

class CheckEvaluationDoneProvider with ChangeNotifier {
  bool isFileUploaded = false;
  bool isEvaluationDone = false;

  void setIsFileUploaded(bool newIsFileUploaded) {
    isFileUploaded = newIsFileUploaded;
    notifyListeners();
  }

  bool getIsFileUploaded() => isFileUploaded;

  void setIsEvaluationDone(bool newIsEvaluationDone) {
    isEvaluationDone = newIsEvaluationDone;
  }

  bool getIsEvaluationDone() => isEvaluationDone;
}