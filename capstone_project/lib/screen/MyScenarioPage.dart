import 'package:capstone_project/screen/CreateSpeechPage.dart';
import 'package:capstone_project/screen/CreateScenarioPage.dart';
import 'package:capstone_project/component/BasicAppBar.dart';
import 'package:capstone_project/component/EmotionCard.dart';
import 'package:capstone_project/model/bringScenarioDto.dart';
import 'package:capstone_project/network/my_scenario_service.dart';
import 'package:flutter/material.dart';

class MyScenarioPage extends StatefulWidget {
  final int scenarioId;
  MyScenarioPage({super.key, required this.scenarioId});

  static String routeName = "/my_scenario_page";

  @override
  State<StatefulWidget> createState() => _SpeechState();
}

class _SpeechState extends State<MyScenarioPage> {
  bool scenarioMode = true;
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
                child: BasicAppBar(scenarioCard.title)),
            body: ListView.builder(
                itemCount: scenarioCard.sentences.length,
                itemBuilder: (BuildContext context, int index) {
                  return EmotionCard(
                      scenarioCard.sentences[index].id,
                      scenarioCard.sentences[index].isSuccess,
                      scenarioCard.sentences[index].sentence,
                      scenarioCard.sentences[index].emotion,
                      scenarioCard.title);
                }),
            floatingActionButton: Container(
              height: 45.0,
              width: 45.0,
              child: FittedBox(
                  child: FloatingActionButton(
                shape: CircleBorder(),
                onPressed: () {
                  if (scenarioMode == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateScenarioPage(
                                  scenarioId: widget.scenarioId,
                                  text: "",
                                  emotion: "",
                                  isRevise: false,
                                  userId: 1,
                                )));
                  } else if (scenarioMode == false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateSpeechPage(
                                  scenarioId: widget.scenarioId,
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
