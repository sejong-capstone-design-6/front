
import 'package:capstone_project/CreateScenarioPage.dart';
import 'package:capstone_project/CreateSpeechPage.dart';
import 'package:capstone_project/model/bringScenarioDto.dart';
import 'package:capstone_project/network/my_scenario_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmotionCard extends StatefulWidget {
  int scenarioID;
  bool? isSuccess;
  String scenario;
  String emotion;
  bool isScenario;
  EmotionCard(this.scenarioID,this.isSuccess,this.scenario, this.emotion,this.isScenario);

  @override
  State<EmotionCard> createState() => _EmotionCardState();
}

class _EmotionCardState extends State<EmotionCard> {

  @override
  Widget build(BuildContext context) {
    int _scenarioID=widget.scenarioID;
    bool _isScenario=widget.isScenario;
    
    double wdth=MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      width: double.infinity,
      height: 128.0,
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              print("ssssss");
            },

            child: Container(
            width: 20,
            height: double.infinity,
              child: Icon(
                color: Colors.white,
                Icons.mic_none,
                size: 20.0,
              ),
            ),
          ),
          

          Positioned(
            left: 30,
            child: InkWell(
              onTap: (){
                if(_isScenario==true){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateScenarioPage(scenarioId: widget.scenarioID, text: widget.scenario, emotion: widget.emotion, isrevise: true,)));
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateSpeechPage(scenarioId: widget.scenarioID, text: widget.scenario, emotion: widget.emotion, isrevise: true,)));
                }
              },
              child: Stack(
                children: 
                [
                  Container(
                  width: wdth-62,
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30),),
                    color: Color.fromARGB(255, 28, 28, 30),
                    ),
                  ),
                
                
                  Positioned(
                    left: 16,
                    top: 16,
                    width: wdth-94,
                    child: 
                      Text(widget.scenario,
                      style: TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      ),
                  ),



                  Positioned(
                    left: 16,
                    top: 102,
                    child:Row(
                      children: [
                        getSuccessicon(widget.isSuccess),
                        SizedBox(
                        width: 4,
                        ),
                        getSuccess(widget.isSuccess),
                      ],
                    )
                  ),

                  Positioned(
                    width: 100,
                    left: wdth-180,
                    top: 102,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        getEmotion(widget.emotion),
                        SizedBox(
                          width: 4,
                        ),
                        getEmotionicon(widget.emotion),
                      ],
                    )
                  ) 
                ]
              ),
            )
          ),
        ],
      ),
    );
  }


  Widget getSuccessicon(bool? value){
    if (value==true) {
      return Icon(Icons.circle,color: Color.fromARGB(255, 65, 105, 225),size: 16,);
    }
    else if(value==false){
      return Icon(Icons.circle,color: Color.fromARGB(255, 172, 0, 0),size: 16,);
    }
    else{
      return Text("");
    }
  }


  
  Widget getSuccess(bool? value){
    if (value == false) {
      return Text("실패",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 172, 0, 0), fontWeight: FontWeight.bold),);
    }
    else if(value==true){
      return Text("성공",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 65, 105, 225),fontWeight: FontWeight.bold),);
    }
    else{
      return Text("");
    }
  }


  Widget getEmotionicon(String value){
    if (value=="평범") {
      return Icon(Icons.circle,color: Color.fromARGB(255, 255, 255, 255),size: 16,);
    }
    else if(value=="강조"||value=="분노"){
      return Icon(Icons.circle,color: Color.fromARGB(255, 219, 1, 56),size: 16,);
    }
    else if(value=="기뻐")
    {
      return Icon(Icons.circle,color: Color.fromARGB(255, 255, 215, 0),size: 16,);
    }
    else if(value=="슬퍼")
    {
      return Icon(Icons.circle,color: Color.fromARGB(255, 58, 58, 255),size: 16,);
    }
    else if(value=="놀라")
    {
      return Icon(Icons.circle,color: Color.fromARGB(255, 50, 205, 50),size: 16,);
    }
    else if(value=="두려워")
    {
      return Icon(Icons.circle,color: Color.fromARGB(255, 142, 154, 48),size: 16,);
    }
    else{
      return Text("");
    }
  }


  Widget getEmotion(String value){
    if (value=="평범") {
      return Text(value,style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),);
    }
    else if(value=="강조"||value=="분노"){
      return Text(value,style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 219, 1, 56),fontWeight: FontWeight.bold),);
    }
    else if(value=="기뻐"){
      return Text(value,style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 255, 215, 0),fontWeight: FontWeight.bold),);
    }
    else if(value=="슬퍼"){
      return Text(value,style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 58, 58, 255),fontWeight: FontWeight.bold),);
    }
    else if(value=="놀라"){
      return Text(value,style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 50, 205, 50),fontWeight: FontWeight.bold),);
    }
    else if(value=="두려워"){
      return Text(value,style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 142, 154, 48),fontWeight: FontWeight.bold),);
    }
    else{
      return Text("");
    }
  }


}