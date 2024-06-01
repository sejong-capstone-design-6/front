import 'package:capstone_project/component/EmotionChip.dart';
import 'package:capstone_project/model/createScenarioDto.dart';
import 'package:capstone_project/model/reviseScenarioDto.dart';
import 'package:capstone_project/model/reviseSentenceDto.dart';
import 'package:capstone_project/network/my_scenario_service.dart';
import 'package:capstone_project/network/revise_sentence_service.dart';
import 'package:capstone_project/provider/my_scenario_provider.dart';
import 'package:capstone_project/screen/MyScenarioPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateSpeechPage extends StatefulWidget {
  CreateSpeechPage(
      {super.key,
      required this.title,
      required this.userId,
      required this.scenarioId,
      required this.text,
      required this.emotion,
      required this.isRevise});
  final int userId;
  final int scenarioId;
  final String text;
  final String emotion;
  final bool isRevise;
  final String title;

  @override
  State<StatefulWidget> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<CreateSpeechPage> {
  bool isnormal = false;
  bool isaccent = false;
  bool isRevising = false;
  late List<bool> isSelected;

  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.text;
    if (widget.emotion == "평범") {
      isnormal = true;
    } else if (widget.emotion == "강조") {
      isaccent = true;
    }
    isSelected = [isnormal, isaccent];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyScenarioProvider>().setScenarioId(widget.scenarioId);
      context.read<MyScenarioProvider>().setMode('스피치');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _userId = widget.userId;
    int _scenarioID = widget.scenarioId;
    String _emotion = widget.emotion;
    double weth = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;

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
                  } else if (isaccent == true) {
                    _emotion = "강조";
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
                                  MyScenarioPage(scenarioId: _scenarioID, mode: "스피치")));
                    } else {
                      showSnackDeny(context);
                    }
                  } else {
                    dynamic response =
                        await reviseSentenceService.ReviseSentence(
                            ReviseSentenceDto(_scenarioID, text, _emotion));
                    if (response.statusCode == 200) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyScenarioPage(scenarioId: _userId, mode: "스피치")));
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
                      padding: EdgeInsets.symmetric(horizontal: 16), //간격=16
                      child: Row(
                        children: [EmotionChip("평범")],
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [EmotionChip("강조")],
                      )),
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
                    backgroundColor: Color.fromARGB(255, 0, 125, 167),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10.0)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color(0xff525252),
                          content: Text(
                            '스피치를 위한 어투로 교정합니다.\n내용의 일부가 바뀔 수도 있습니다.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        );
                      });
                  String text = _controller.text;
                  myScenarioService
                      .reviseSentence(ReviseScenarioDto(text))
                      .then((data) {
                    setState(() {
                      _controller.text = data.text;
                    });
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "AI",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ))
        ],
      ),
    );
  }

  void toggleselect(value) {
    if (value == 0) {
      isnormal = true;
      isaccent = false;
    } else {
      isnormal = false;
      isaccent = true;
    }
    setState(() {
      isSelected = [isnormal, isaccent];
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
