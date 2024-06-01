import 'package:capstone_project/screen/CreateSpeechPage.dart';
import 'package:capstone_project/screen/CreateScenarioPage.dart';
import 'package:capstone_project/component/EmotionCard.dart';
import 'package:capstone_project/model/bringScenarioDto.dart';
import 'package:capstone_project/network/my_scenario_service.dart';
import 'package:flutter/material.dart';

class MyScenarioPage extends StatefulWidget {
  final int scenarioId;
  final String mode;
  MyScenarioPage({super.key, required this.scenarioId, required this.mode});

  static String routeName = "/my_scenario_page";

  @override
  State<StatefulWidget> createState() => _SpeechState();
}

class _SpeechState extends State<MyScenarioPage> {
  late BringScenarioDto scenarioCard;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    myScenarioService.bringScenario(widget.scenarioId).then((value) {
      scenarioCard = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold()
        : Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(48.0),
                child: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    color: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_left),
                    iconSize: 24,
                  ),
                  title: Text(
                    scenarioCard.title,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  centerTitle: true,
                  titleSpacing: 6.5,
                )),
            body: ListView.builder(
                itemCount: scenarioCard.sentences.length,
                itemBuilder: (BuildContext context, int index) {
                  return EmotionCard(
                      widget.scenarioId,
                      scenarioCard.sentences[index].id,
                      scenarioCard.sentences[index].isSuccess,
                      scenarioCard.sentences[index].sentence,
                      scenarioCard.sentences[index].emotion,
                      scenarioCard.title,
                      widget.mode);
                }),
            floatingActionButton: Container(
              height: 45.0,
              width: 45.0,
              child: FittedBox(
                  child: FloatingActionButton(
                shape: CircleBorder(),
                onPressed: () {
                  if (widget.mode == "연기") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateScenarioPage(
                                  title: scenarioCard.title,
                                  userId: scenarioCard.id,
                                  scenarioId: widget.scenarioId,
                                  text: "",
                                  emotion: "",
                                  isRevise: false,
                                )));
                  } else if (widget.mode == "스피치") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateSpeechPage(
                                  userId: scenarioCard.id,
                                  scenarioId: widget.scenarioId,
                                  title: scenarioCard.title,
                                  text: "",
                                  emotion: "",
                                  isRevise: false,
                                )));
                  }
                },
                backgroundColor: Color.fromARGB(255, 0, 125, 167),
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
              )),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
