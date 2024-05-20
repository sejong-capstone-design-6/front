import 'dart:convert';
import 'package:capstone_project/component/ScenarioModel.dart';
import 'package:capstone_project/network/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://13.125.172.71:4000';
  final String scenarioApi = 'my-scenarios';
  final String contentApi = 'sentences';
  int? _userId = authSercive.userId;

  Future postScenario(String mode, String title) async {
    int scenarioId;
    Map<String, dynamic> data = {
      'userId': _userId,
      'type': mode,
      'title': title,
    };

    String requestBody = jsonEncode(data);

    final url = Uri.parse('$baseUrl/$scenarioApi');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );

    if (response.statusCode == 201) {
      print('POST Success!');
      print('응답: ${response.body}');
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      scenarioId = jsonResponse['scenarioId'];
      return scenarioId; // scenarioId;
    } else {
      print('POST Failed..: ${response.statusCode}');
      throw Error();
    }
  }

  void postContent(String content) async {
    Map<String, dynamic> data = {
      'scenarioId': 1,
      'text': content,
      'emotion': '평범',
    };
    String requestBody = jsonEncode(data);

    final url = Uri.parse('$baseUrl/$scenarioApi/$contentApi');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );
    if (response.statusCode == 201) {
      print('POST Success!');
      print('응답: ${response.body}');
      return;
    } else {
      print('POST Failed..: ${response.statusCode}');
      throw Error();
    }
  }

  //Future<List<ScenarioModel>> getMyScenarios() async {
  Future<ScenarioList> getMyScenarios() async {
    String uid = _userId.toString();
    final url = Uri.parse('$baseUrl/$scenarioApi')
        .replace(queryParameters: {'uid': uid});
    final response = await http.get(url);

    Map<String, dynamic> jsonResponse;
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      return ScenarioList.fromJson(jsonResponse);
    } else {
      print(response.statusCode);
      throw Error();
    }
  }
}
