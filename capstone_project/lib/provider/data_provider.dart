import 'dart:convert';
import 'package:capstone_project/model/bringScenarioDto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/date.dart';

class scenairoProvider extends ChangeNotifier{
  List<BringScenarioDto> scenario = [];
  int currentpageno=1;
  bool isAdd=false;

  Future<void> started() async{
    await _getScenario();
  }

  Future<void> _getScenario() async{
    
  }
}