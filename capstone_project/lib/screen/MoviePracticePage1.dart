import 'package:capstone_project/component/MovieVideoPlayer.dart';
import 'package:capstone_project/model/bringScenarioSentenceDto.dart';
import 'package:capstone_project/network/movie_scenario_service.dart';
import 'package:capstone_project/screen/MoviePracticePage2.dart';
import 'package:flutter/material.dart';

class MoviePracticePage1 extends StatefulWidget {
  final int id;
  final String title;
  final String url;

  MoviePracticePage1(
      {super.key, required this.id, required this.title, required this.url});

  @override
  State<StatefulWidget> createState() => _MoviePracticePage1();
}

class _MoviePracticePage1 extends State<MoviePracticePage1> {
  late BringScenarioSentenceDto scenarioSentenceDto;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    scenarioSentenceDto =
        await movieScenarioService.bringScenarioSentence(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            widget.title,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          centerTitle: true,
          titleSpacing: 6.5,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14, top: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MovieVideoPlayer(url: widget.url),
                  SizedBox(height: 14),
                  Expanded(
                    // Using Expanded to fill remaining space
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff1C1C1E),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: ListView.builder(
                        itemCount: scenarioSentenceDto.sentences.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              scenarioSentenceDto.sentences[index].speaker,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                                scenarioSentenceDto.sentences[index].text,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: SizedBox(
          width: 45,
          height: 45,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MoviePracticePage2(
                          id: widget.id,
                          title: widget.title,
                          sentences: scenarioSentenceDto.sentences)));
            },
            backgroundColor: Color.fromARGB(255, 0, 125, 167),
            shape: CircleBorder(),
            child: Icon(
              Icons.mic_none,
              size: 30,
              color: Colors.white,
              weight: 0.5,
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
