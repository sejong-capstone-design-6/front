import 'dart:convert';


import 'package:capstone_project/model/bringScenarioDto.dart';

import 'package:capstone_project/network/const.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class MyScenarioService{
  String myScenarioUrl = '$curServerUrl/my-scenarios';

  MyScenarioService();
  

  Future<BringScenarioDto> bringScenario(int scenarioId) async{
    try{
      final url= Uri.parse("$myScenarioUrl/$scenarioId");
      final response= await http.get(url);
      if(response.statusCode==200){
        final jsonData=json.decode(response.body);
        final scenarioDto=BringScenarioDto.fromJson(jsonData);
        return scenarioDto;
      }
      else{
        throw Exception(response.statusCode);
      }
      
    }
    catch(e){
      Logger().d(e);
      throw Exception(e);
    }
  }
}

MyScenarioService myScenarioService = MyScenarioService();
