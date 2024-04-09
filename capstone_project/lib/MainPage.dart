

import 'package:flutter/material.dart';


class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60.0,
          title: const Text("마음의소리",
            style: TextStyle(
              fontSize: 32,color: Colors.white),),
          titleSpacing: 16.0,),
    );
  }
      

}
