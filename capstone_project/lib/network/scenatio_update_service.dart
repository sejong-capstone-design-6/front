import 'dart:convert';


import 'package:capstone_project/model/createScenarioDto.dart';
import 'package:capstone_project/network/const.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ScenarioUpdateService{
  String scenarioUpdateUrl = '$curServerUrl/my-scenarios';

  Future<dynamic> UpdateSceanrio(CreateScenarioDto dto) async{
    try{
      final url= Uri.parse("$scenarioUpdateUrl/sentences");
      
      final response = await http.post(url, body: jsonEncode(dto.toJson()),headers: {"Content-Type":"application/json"});//headers: {"Content-Type":"application/json"}
      Logger().d(response.body);
      Logger().d(response.statusCode);
      return response.statusCode; 

    }
    catch (e){
      Logger().d(e);
    }
  }
}

ScenarioUpdateService scenarioUpdateService = ScenarioUpdateService();
