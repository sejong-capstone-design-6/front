import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CheckEvaluationDoneProvider with ChangeNotifier {
  bool isFileUploaded = false;
  bool isEvaluationDone = false;

  void setIsFileUploaded(bool newIsFileUploaded) {
    isFileUploaded = newIsFileUploaded;
    Logger().d('work123');
    notifyListeners();
  }

  bool getIsFileUploaded() => isFileUploaded;

  void setIsEvaluationDone(bool newIsEvaluationDone) {
    isEvaluationDone = newIsEvaluationDone;
  }

  bool getIsEvaluationDone() => isEvaluationDone;
}