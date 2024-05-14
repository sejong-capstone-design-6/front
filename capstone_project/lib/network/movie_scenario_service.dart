import 'dart:convert';

import 'package:capstone_project/model/bringScenarioSentenceDto.dart';
import 'package:capstone_project/network/const.dart';
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
}

MovieScenarioService movieScenarioService = new MovieScenarioService();