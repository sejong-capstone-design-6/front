import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://13.125.172.71:4000';
  final String restApi = 'my-scenarios';

  void postScenario(String mode, String title) async {
    Map<String, dynamic> data = {
      'userId': 1,
      'type': mode,
      'title': title,
    };

    String requestBody = jsonEncode(data);

    final url = Uri.parse('$baseUrl/$restApi');
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
}
