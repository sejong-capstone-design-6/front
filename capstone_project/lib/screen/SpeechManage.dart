import 'package:capstone_project/Card/EmotionCard.dart';
import 'package:capstone_project/SpeechEdit.dart';
import 'package:flutter/material.dart';





class SpeechManage extends StatefulWidget{
  const SpeechManage({super.key});

  @override
  State<StatefulWidget> createState()=> _MyCheckBoxState();
  

}

class _MyCheckBoxState extends State<SpeechManage>{
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
      

      body:  ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index){
            return EmotionCard(1);
          }
        ),
        floatingActionButton: Container(
          height: 45.0,
          width: 45.0,
          child: FittedBox(
            child: FloatingActionButton(
              shape: CircleBorder(),
              onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>SpeechEdit()));
              },
              backgroundColor: Color.fromARGB(255, 0, 125, 167),
              child: Icon(Icons.add,size: 50,color: Colors.white,),

              )),
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      );
  
  }
    
    
}
      


