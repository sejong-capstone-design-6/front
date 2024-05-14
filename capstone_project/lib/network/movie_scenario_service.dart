import 'dart:convert';

import 'package:capstone_project/model/bringMovieTranscriptDto.dart';
import 'package:capstone_project/model/bringScenarioSentenceDto.dart';
import 'package:capstone_project/model/bringTranscriptIdDto.dart';
import 'package:capstone_project/model/checkEvaluationProgressDto.dart';
import 'package:capstone_project/network/const.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:http/http.dart' as http;

class MovieScenarioService {
  String movieScenarioUrl = '$curServerUrl/movie-scenarios';

  MovieScenarioService();

  Future<BringScenarioSentenceDto> bringScenarioSentence(int scenarioId) async {
    try {
      final url = Uri.parse("$movieScenarioUrl/$scenarioId");
      final response = await http.get(url);

      if(response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final dto = BringScenarioSentenceDto.fromJson(jsonData);
        return dto;
      } else {
        throw Exception(response.statusCode);
      }
    } catch(e) {
      Logger().d(e);
      throw Exception(e);
    }
  }

  Future<BringTranscriptIdDto> uploadVoice(int scenarioId, int userId, String filePath) async {
    try {
      var dio = Dio();
      var formData =
          FormData.fromMap({'file': await MultipartFile.fromFile(filePath)});

      final response = await dio.post(
          '$movieScenarioUrl/$scenarioId/evaluations?uid=$userId',
          data: formData);

      if (response.statusCode == 201) {
        final dto = BringTranscriptIdDto.fromJson(response.data);
        return dto;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      Logger().e(e);
      throw Exception();
    }
  }

  Future<CheckEvaluationProgressDto> checkEvaluationComplete(
      int scenarioId, int transcriptId) async {
    try {
      final url = Uri.parse(
          "$movieScenarioUrl/$scenarioId/evaluations/$transcriptId/progress");
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

    Future<BringMovieTranscriptDto> bringTranscript(
      int scenarioId, int transcriptId) async {
    try {
      final url = Uri.parse(
          "$movieScenarioUrl/$scenarioId/evalution-histories/$transcriptId");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final transcriptDto = BringMovieTranscriptDto.fromJson(jsonData);
        return transcriptDto;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }
}

MovieScenarioService movieScenarioService = new MovieScenarioService();