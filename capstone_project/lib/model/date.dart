import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier{
     
  int userId=0;
  String email=""; 
  String password="";

  int? getId()=>userId;
  void setId(String _ID){
    email=_ID;
    notifyListeners();
  }

  String? getEmail()=>email;
  void setEmail(String _email){
    email=_email;
    notifyListeners();
  }

  String? getPW()=>password;
  void setPW(String _PW){
    password=_PW;
    notifyListeners();
  }

  //UserInfo({this.userId, this.email, this.password});
    
          
}