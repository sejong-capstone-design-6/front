import 'package:capstone_project/component/EmotionChip.dart';
import 'package:capstone_project/screen/BasicPracticePage.dart';
import 'package:capstone_project/screen/CreateScenarioPage.dart';
import 'package:capstone_project/screen/CreateSpeechPage.dart';
import 'package:flutter/material.dart';
class EmotionCard extends StatefulWidget {
  final int userId;
  final int scenarioID;
  final bool? isSuccess;
  final String scenario;
  final String emotion;
  final String title;
  final String mode;
  EmotionCard(
      this.userId, this.scenarioID, this.isSuccess, this.scenario, this.emotion, this.title, this.mode);

  @override
  State<EmotionCard> createState() => _EmotionCardState();
}

class _EmotionCardState extends State<EmotionCard> {
  @override
  Widget build(BuildContext context) {
    String mode=widget.mode;
    int _userId=widget.userId;
    int _scenarioID = widget.scenarioID;

    double wdth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      width: double.infinity,
      height: 128.0,
      child: Stack(
        children: [
          Container(
              width: 20,
              height: double.infinity,
              child: InkWell(
                child: Icon(
                  color: Colors.white,
                  Icons.mic_none,
                  size: 20.0,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BasicPracticePage(
                                id: _scenarioID,
                                title: widget.title,
                                text: widget.scenario,
                                emotion: widget.emotion,
                              )));
                },
              )),
          Positioned(
            left: 30,
            child: InkWell(
              onTap: (){
                if(mode=="연기"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateScenarioPage(userId: _userId, scenarioId: _scenarioID, text: widget.scenario, emotion: widget.emotion, isRevise: true,)));
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateSpeechPage(userId: _userId, scenarioId: _scenarioID, text: widget.scenario, emotion: widget.emotion, isRevise: true,)));
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
                        EmotionChip(widget.emotion)
                      ],
                    )
                  ) 
                ]
              ),
            )
          )
            
              
        ],
      ),
    );
  }

  Widget getSuccessicon(bool? value) {
    if (value == true) {
      return Icon(
        Icons.circle,
        color: Color.fromARGB(255, 65, 105, 225),
        size: 16,
      );
    } else if (value == false) {
      return Icon(
        Icons.circle,
        color: Color.fromARGB(255, 172, 0, 0),
        size: 16,
      );
    } else {
      return Text("");
    }
  }

  Widget getSuccess(bool? value) {
    if (value == false) {
      return Text(
        "실패",
        style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 172, 0, 0),
            fontWeight: FontWeight.bold),
      );
    } else if (value == true) {
      return Text(
        "성공",
        style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 65, 105, 225),
            fontWeight: FontWeight.bold),
      );
    } else {
      return Text("");
    }
  }
}
