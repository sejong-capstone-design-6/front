import 'package:capstone_project/component/BasicAppBar.dart';
import 'package:capstone_project/model/bringScenarioSentenceDto.dart';
import 'package:capstone_project/network/movie_scenario_service.dart';
import 'package:flutter/material.dart';

class MoviePracticePage1 extends StatefulWidget {
  final int id;
  final String title;

  MoviePracticePage1({super.key, required this.id, required this.title});

  @override
  State<StatefulWidget> createState() => _MoviePracticePage1();
}

class _MoviePracticePage1 extends State<MoviePracticePage1> {
  late BringScenarioSentenceDto scenarioSentenceDto;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    movieScenarioService
        .bringScenarioSentence(widget.id)
        .then((value) => scenarioSentenceDto = value);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: BasicAppBar(widget.title),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: Container(
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      height: double.infinity,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Color(0xff1C1C1E),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: ListView.builder(
                            itemCount: scenarioSentenceDto.sentences.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Text(
                                    scenarioSentenceDto
                                        .sentences[index].speaker,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      scenarioSentenceDto.sentences[index].text,
                                      style: TextStyle(fontSize: 14))
                                ],
                              );
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: FittedBox(
              child: FloatingActionButton(
                shape: CircleBorder(),
                onPressed: () {},
                backgroundColor: Color.fromARGB(255, 0, 125, 167),
                child: Icon(Icons.mic, size: 50, color: Colors.white),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
