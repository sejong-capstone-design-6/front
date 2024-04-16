
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmotionCard extends StatefulWidget {
  int number;
  EmotionCard(this.number);

  @override
  State<EmotionCard> createState() => _EmotionCardState();
}

class _EmotionCardState extends State<EmotionCard> {

  @override
  Widget build(BuildContext context) {
    double wdth=MediaQuery.of(context).size.width;
    int is_success1=0; //false
    int is_success2=1; //true
    int is_success3=2; //null

    int emotionvalue1=1;
    int emotionvalue2=2;
    int emotionvalue3=3;
    int emotionvalue4=4;
    int emotionvalue5=5;
    int emotionvalue6=6;
    int emotionvalue7=7;



    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      width: double.infinity,
      height: 128.0,
      child: Stack(
        children: [
          Container(
            width: 20,
            height: double.infinity,
            child: Icon(
              
              color: Colors.white,
              Icons.mic_none,
              size: 20.0,
            ),
          ),


          Positioned(
            left: 30,
            child: Container(
              width: wdth-62,
              height: 128,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30),),
                color: Color.fromARGB(255, 28, 28, 30),
              ),
            ),
          ),

          Positioned(
            left: 46,
            top: 16,
            width: wdth-94,
            child: Text("wwwwwwww\nwwww\nwwww\nwwwwwwww",
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            )
          ),

          Positioned(
            left: 46,
            top: 102,
            child:Row(
              children: [
                getSuccessicon(is_success2),
                SizedBox(
                  width: 4,
                ),
                getSuccess(is_success2),
              ],
            )

          ),

          Positioned(
            width: 100,
            left: wdth-150,
            top: 102,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                getEmotion(emotionvalue1),
                SizedBox(
                  width: 4,
                ),
                getEmotionicon(emotionvalue1),
              ],
            )
            )
          

          


        ],
      ),
    );

  }


  Widget getSuccessicon(int value){
    if (value==1) {
      return Icon(Icons.circle,color: Color.fromARGB(255, 65, 105, 225),size: 16,);
    }
    else if(value==0){
      return Icon(Icons.circle,color: Color.fromARGB(255, 172, 0, 0),size: 16,);
    }
    else{
      return Text("");
    }
  }


  
  Widget getSuccess(int value){
    if (value==0) {
      return Text("실패",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 172, 0, 0), fontWeight: FontWeight.bold),);
    }
    else if(value==1){
      return Text("성공",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 65, 105, 225),fontWeight: FontWeight.bold),);
    }
    else{
      return Text("");
    }
  }


  Widget getEmotionicon(int value){
    if (value==1) {
      return Icon(Icons.circle,color: Color.fromARGB(255, 65, 105, 225),size: 16,);
    }
    else if(value==0){
      return Icon(Icons.circle,color: Color.fromARGB(255, 172, 0, 0),size: 16,);
    }
    else{
      return Text("");
    }
  }


  Widget getEmotion(int value){
    if (value==0) {
      return Text("실패",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 172, 0, 0), fontWeight: FontWeight.bold),);
    }
    else if(value==1){
      return Text("성공",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 65, 105, 225),fontWeight: FontWeight.bold),);
    }
    else{
      return Text("");
    }
  }


}