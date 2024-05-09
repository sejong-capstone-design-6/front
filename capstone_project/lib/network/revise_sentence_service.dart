import 'dart:convert';

import 'package:capstone_project/model/reviseSentenceDto.dart';
import 'package:capstone_project/network/const.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ReviseSentenceService{
  String scenarioUpdateUrl = '$curServerUrl/my-scenarios';

  Future<dynamic> ReviseSentence(ReviseSentenceDto dto) async{
    try{
      final url= Uri.parse("$scenarioUpdateUrl/sentences/revise");      
      final response = await http.post(url, body: jsonEncode(dto.toJson()),headers: {"Content-Type":"application/json"});
      return response; 
    }
    catch (e){
      Logger().d(e);
    }
  }
}

ReviseSentenceService reviseSentenceService = ReviseSentenceService();
