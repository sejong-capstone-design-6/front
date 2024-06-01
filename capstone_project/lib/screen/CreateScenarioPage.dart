import 'package:capstone_project/component/EmotionChip.dart';
import 'package:capstone_project/model/createScenarioDto.dart';
import 'package:capstone_project/model/reviseSentenceDto.dart';
import 'package:capstone_project/network/my_scenario_service.dart';
import 'package:capstone_project/network/revise_sentence_service.dart';
import 'package:capstone_project/provider/my_scenario_provider.dart';
import 'package:capstone_project/screen/MyScenarioPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateScenarioPage extends StatefulWidget {
  final int userId;
  final int scenarioId;
  final String text;
  final String emotion;
  final bool isRevise;
  final String title;

  CreateScenarioPage(
      {super.key,
      required this.title,
      required this.userId,
      required this.scenarioId,
      required this.text,
      required this.emotion,
      required this.isRevise});

  @override
  State<StatefulWidget> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<CreateScenarioPage> {
  bool isnormal = false;
  bool ishappy = false;
  bool isanger = false;
  bool issad = false;
  bool issurprise = false;
  bool isfeared = false;

  late List<bool> isSelected;

  final _controller = TextEditingController();

  void initState() {
    _controller.text=widget.text;
    if (widget.emotion == "평범") {
      isnormal = true;
    } else if (widget.emotion == "웃음") {
      ishappy = true;
    } else if (widget.emotion == "분노") {
      isanger = true;
    } else if (widget.emotion == "슬픔") {
      issad = true;
    } else if (widget.emotion == "놀라움") {
      issurprise = true;
    } else if (widget.emotion == "두려움") {
      isfeared = true;
    }
    isSelected = [isnormal, ishappy, isanger, issad, issurprise, isfeared];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _scenarioID = widget.scenarioId;
    String _emotion = widget.emotion;
    double weth = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    context.read<MyScenarioProvider>().setScenarioId(_scenarioID);
    context.read<MyScenarioProvider>().setMode('연기');
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.white,
            icon: Icon(Icons.keyboard_arrow_left),
            iconSize: 24,
          ),
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          centerTitle: true,
          titleSpacing: 6.5,
          actions: [
            TextButton(
                onPressed: () async {
                  String text = _controller.text;
                  if (isnormal == true) {
                    _emotion = "평범";
                  } else if (ishappy == true) {
                    _emotion = "웃음";
                  } else if (isanger == true) {
                    _emotion = "분노";
                  } else if (issad == true) {
                    _emotion = "슬픔";
                  } else if (issurprise == true) {
                    _emotion = "놀라움";
                  } else if (isfeared == true) {
                    _emotion = "두려움";
                  }

                  dynamic statusCode;
                  if (widget.isRevise == false) {
                    statusCode = await myScenarioService.updateSceanrio(
                        CreateScenarioDto(_scenarioID, text, _emotion));
                    if (statusCode == 201) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyScenarioPage(scenarioId: _scenarioID, mode: "연기",)));
                    } else {
                      showSnackDeny(context);
                    }
                  } else {
                    dynamic response =
                        await reviseSentenceService.ReviseSentence(
                            ReviseSentenceDto(_scenarioID,text,_emotion));
                    if (response.statusCode == 200) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyScenarioPage(scenarioId: _scenarioID, mode: "연기")));
                    } else {    
                      showSnackDeny(context);
                    }
                  }
                },
                child: Text(
                  "완료",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ))
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
                    height: hight - 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromARGB(255, 28, 28, 30),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 28, 28, 30)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 28, 28, 30))),
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
              width: weth - 32.0,
              child: ToggleButtons(
                selectedColor: Colors.black, //선택글자 색
                fillColor: Colors.blueGrey, //선택 칸 색
                color: Colors.white,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7), //간격=16
                      child: Row(
                        children: [
                          EmotionChip("평범")
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Row(
                        children: [
                          EmotionChip("웃음")
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7), //간격=16
                      child: Row(
                        children: [
                          EmotionChip("분노")
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7), //간격=16
                      child: Row(
                        children: [
                          EmotionChip("슬픔")
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1), //간격=16
                      child: Row(
                        children: [
                          EmotionChip("놀라움")
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1), //간격=16
                      child: Row(
                        children: [
                          EmotionChip("두려움")
                        ],
                      )),
                ],
                isSelected: isSelected,
                onPressed: toggleselect,
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  void toggleselect(value) {
    if (value == 0) {
      isnormal = true;
      ishappy = false;
      isanger = false;
      issad = false;
      issurprise = false;
      isfeared = false;
    } else if (value == 1) {
      isnormal = false;
      ishappy = true;
      isanger = false;
      issad = false;
      issurprise = false;
      isfeared = false;
    } else if (value == 2) {
      isnormal = false;
      ishappy = false;
      isanger = true;
      issad = false;
      issurprise = false;
      isfeared = false;
    } else if (value == 3) {
      isnormal = false;
      ishappy = false;
      isanger = false;
      issad = true;
      issurprise = false;
      isfeared = false;
    } else if (value == 4) {
      isnormal = false;
      ishappy = false;
      isanger = false;
      issad = false;
      issurprise = true;
      isfeared = false;
    } else if (value == 5) {
      isnormal = false;
      ishappy = false;
      isanger = false;
      issad = false;
      issurprise = false;
      isfeared = true;
    }
    setState(() {
      isSelected = [isnormal, ishappy, isanger, issad, issurprise, isfeared];
    });
  }
}

void showSnackDeny(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text(
      '문제가 발생했습니다.',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}
