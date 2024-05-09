import 'dart:convert';


import 'package:capstone_project/model/signUpDto.dart';
import 'package:capstone_project/network/const.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AuthSercive{
  String authUrl = '$curServerUrl/auth';

  Future<dynamic> signUp(SignUpDto dto) async{
    try{
      final url= Uri.parse("$authUrl/signup");
      final response = await http.post(url, body: jsonEncode(dto.toJson()), headers: {"Content-Type":"application/json"},);
      return response.statusCode; // 201이면 로그인 페이지로 이동, 아니면 문제가 발생했다는 스낵바 하나 띄어주세요.
    }
    catch (e){
      Logger().d(e);
    }
  }
}

AuthSercive authSercive = AuthSercive();