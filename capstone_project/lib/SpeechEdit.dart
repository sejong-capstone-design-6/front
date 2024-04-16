import 'package:capstone_project/Card/EmotionCard.dart';
import 'package:flutter/material.dart';





class SpeechEdit extends StatefulWidget{
  const SpeechEdit({super.key});

  @override
  State<StatefulWidget> createState()=> _MyCheckBoxState();
  

}

class _MyCheckBoxState extends State<SpeechEdit>{
  bool scienarioMode=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          leading: IconButton(
            onPressed: (){
        
            },
            color: Colors.white,
            icon: Icon(Icons.keyboard_arrow_left),
            iconSize: 24,
          ),
          title: Text("Capstone Speech",
            style: TextStyle(
              fontSize: 16,color: Colors.white),),
        
              centerTitle: true,
        
            titleSpacing: 6.5,),
      ),
      

      body:  EmotionCard(1)
          
      );
  
  }
    
    
}
      


