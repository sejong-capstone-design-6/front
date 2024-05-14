import 'dart:convert';

import 'package:capstone_project/model/reviseSentenceDto.dart';
import 'package:capstone_project/network/const.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ReviseSentenceService{
  String scenarioUpdateUrl = '$curServerUrl/my-scenarios';

  Future<dynamic> ReviseSentence(ReviseSentenceDto dto) async{
    try{
      int updateScenarioId=dto.scenarioId;
      final url= Uri.parse("$scenarioUpdateUrl/sentences/$updateScenarioId");      
      String a=url.toString();
      String b=dto.text;
      String c=dto.emotion;
      print("$a    $b         $c              $updateScenarioId     $url");
      final response = await http.put(url, body: jsonEncode(dto.toJson()),headers: {"Content-Type":"application/json"});
      Logger().d("$response");
      var o=response.statusCode;
      print("$o");
      return response; 
    }
    catch (e){
      Logger().d(e);
    }
  }
}

ReviseSentenceService reviseSentenceService = ReviseSentenceService();
