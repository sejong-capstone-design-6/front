import 'package:capstone_project/model/createScenarioDto.dart';
import 'package:capstone_project/model/reviseSentenceDto.dart';
import 'package:capstone_project/network/my_scenario_service.dart';
import 'package:capstone_project/network/revise_sentence_service.dart';
import 'package:capstone_project/screen/MyScenarioPage.dart';
import 'package:flutter/material.dart';






class CreateSpeechPage extends StatefulWidget{
  CreateSpeechPage({super.key,required this.scenarioId,required this.text ,required this.emotion, required this.isRevise});
  final int scenarioId;
  final String text;
  final String emotion;

  final bool isRevise;

  @override
  State<StatefulWidget> createState()=> _MyCheckBoxState();
  

}

class _MyCheckBoxState extends State<CreateSpeechPage>{
  bool isnormal=false;
  bool isaccent=false;
  late List<bool> isSelected;

  void initState(){
    if (widget.emotion=="평범") {
      isnormal=true;
    }
    else if(widget.emotion=="강조"){
      isaccent=true;
    }
    isSelected=[isnormal,isaccent];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    int _scenarioID=widget.scenarioId;
    String _emotion=widget.emotion;
    double weth=MediaQuery.of(context).size.width;
    double hight=MediaQuery.of(context).size.height;
    final _controller= TextEditingController(text: widget.text);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            color: Colors.white,
            icon: Icon(Icons.keyboard_arrow_left),
            iconSize: 24,
          ),
          title: Text("Capstone Speech",
            style: TextStyle(
              fontSize: 16,color: Colors.white),),
          centerTitle: true,
          titleSpacing: 6.5,
          actions: [
            TextButton(onPressed: ()async{
              String text=_controller.text;
              if (isnormal==true) {
                _emotion="평범";
              }
              else if(isaccent==true){
                _emotion="강조";
              }
              dynamic statusCode;
              if(widget.isRevise==false)
              {
                statusCode = await myScenarioService.updateSceanrio(CreateScenarioDto(_scenarioID, text, _emotion));
                if(statusCode==201){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyScenarioPage(scenarioId: _scenarioID)));
                }
                else{
                  showSnackDeny(context);
                }
              }
              else{
                dynamic response = await reviseSentenceService.ReviseSentence(ReviseSentenceDto(text));
                dynamic s=response.body;
                print("$s");
                if(response.statusCode==201){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyScenarioPage(scenarioId: _scenarioID)));
                }
                else{
                  showSnackDeny(context);
                }
              }
            }, 
            child: Text("완료",
              style: TextStyle(color: Colors.white,fontSize: 16.0),))
          ],
        ),
      ),
      

      body: Stack(
        
        children: [
          
          Container(
            height: hight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(16.0),
                    width: double.infinity,
                    height: hight-140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromARGB(255, 28, 28, 30),
                    ),
            
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 28, 28, 30)
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 28, 28, 30)
                          )
                        ),
                      ),
                      maxLines: 25,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          Positioned(
            left: 16.0,
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0),
              color: Color.fromARGB(0, 0, 0, 0),
              height: 40.0,
              width: weth-32.0,
              child: ToggleButtons(
                selectedColor: Colors.black,//선택글자 색
                fillColor: Colors.blueGrey,//선택 칸 색
                color: Colors.white,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),//간격=16
                    child: Row(
                      children: [
                        Text("평범",style: TextStyle(color: Colors.white),),
                        Icon(Icons.circle,color: Colors.white,size: 16,),
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text("강조",style: TextStyle(color: Colors.red),),
                        Icon(Icons.circle,color: Colors.red,size: 16,),
                      ],
                    )
                  ),  
                ],
                isSelected: isSelected,
                onPressed: toggleselect,
              ),
            ),
          ),

          Positioned(
            right: 16.0,
            bottom: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Color.fromARGB(255, 0, 125, 167),
                shape: CircleBorder(),
                padding: EdgeInsets.all(10.0)
              ),
              onPressed: (){},
              child: Text("AI",style: TextStyle(color: Colors.white,fontSize: 18.0),),

          ))
        ],
      ),
    );
  }
    
  void toggleselect(value){
    if(value==0){
      isnormal=true;
      isaccent=false;
    }
    else{
      isnormal=false;
      isaccent=true;
    }
    setState(() {
      isSelected=[isnormal,isaccent];
    });
  }
}
      

void showSnackDeny(BuildContext context){

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: 
    Text('문제가 발생했습니다.',
    textAlign: TextAlign.center,),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,

    )
  );
}
