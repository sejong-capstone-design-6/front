import 'dart:convert';

import 'package:capstone_project/model/bringScenarioDto.dart';
import 'package:capstone_project/model/bringTranscriptDto.dart';
import 'package:capstone_project/model/checkEvaluationProgressDto.dart';
import 'package:capstone_project/model/createScenarioDto.dart';

import 'package:capstone_project/network/const.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class MyScenarioService {
  String myScenarioUrl = '$curServerUrl/my-scenarios';

  MyScenarioService();

  Future<BringScenarioDto> bringScenario(int scenarioId) async {
    try {
      final url = Uri.parse("$myScenarioUrl/$scenarioId");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final scenarioDto = BringScenarioDto.fromJson(jsonData);
        return scenarioDto;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      Logger().d(e);
      throw Exception(e);
    }
  }

  Future<BringTranscriptDto> bringTranscript(
      int sentenceId, int transcriptId) async {
    try {
      final url = Uri.parse(
          "$myScenarioUrl/sentences/$sentenceId/transcripts/$transcriptId");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final transcriptDto = BringTranscriptDto.fromJson(jsonData);
        return transcriptDto;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  Future<CheckEvaluationProgressDto> checkEvaluationComplete(int sentenceId) async {
    try {
      final url = Uri.parse(
          "$myScenarioUrl/sentences/$sentenceId/evaluations/progress");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final progressDto = CheckEvaluationProgressDto.fromJson(jsonData);
        return progressDto;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  Future<dynamic> updateSceanrio(CreateScenarioDto dto) async{
    try{
      final url= Uri.parse("$myScenarioUrl/sentences");
      
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

MyScenarioService myScenarioService = MyScenarioService();
