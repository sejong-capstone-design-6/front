/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/date.dart';

class DataProvider with ChangeNotifier{
  final List<User> _Userlist = List.empty(growable: true);

  List<User> getUserlist(){
    _fetchUsers();
    return _Userlist;
  }

  void _fetchUsers() async{
    final response = await http.get(Uri.parse('https://jsonplacholder.typicode.com/User'))

    final List<User> result = jsonDecode(response.body).map<User>((json)=>User.fromJson(json)).toList();
  }
}*/