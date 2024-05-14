import 'package:capstone_project/component/EvaluationPageUtil.dart';
import 'package:capstone_project/component/TranscriptPageAppBar.dart';
import 'package:capstone_project/model/bringMovieTranscriptDto.dart';
import 'package:capstone_project/model/bringScenarioSentenceDto.dart';
import 'package:capstone_project/network/movie_scenario_service.dart';
import 'package:capstone_project/screen/MoviePracticePage2.dart';
import 'package:flutter/material.dart';

class MovieEvaluationPage extends StatefulWidget {
  final String title;
  final List<Sentence> sentences;
  final int scenarioId;
  final int transcriptId;

  MovieEvaluationPage(
      this.title, this.sentences, this.scenarioId, this.transcriptId);

  @override
  State<StatefulWidget> createState() => _MovieEvaluationPage();
}

class _MovieEvaluationPage extends State<MovieEvaluationPage> {
  bool isLoading = true;
  late BringMovieTranscriptDto transcriptDto;

  @override
  void initState() {
    super.initState();
    movieScenarioService
        .bringTranscript(widget.scenarioId, widget.transcriptId)
        .then((value) {
      transcriptDto = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  Map<String, Color> compareSentences(String sentence1, String sentence2) {
    List<String> words1 = sentence1.split(' ');
    List<String> words2 = sentence2.split(' ');

    // 같은 단어는 파란색, 다른 단어는 회색으로 표시
    Map<String, Color> wordColors = {};

    for (String word in words1) {
      if (words2.contains(word)) {
        wordColors[word] = Color(0xff4169E1);
      } else {
        wordColors[word] = Color(0xff636367);
      }
    }

    for (String word in words2) {
      if (!wordColors.containsKey(word)) {
        wordColors[word] = Color(0xff636367);
      }
    }

    return wordColors;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: TranscriptPageAppBar(widget.title, '/movie_scenario'),
            ),
            body: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Container(
                    height: double.infinity,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Color(0xff1C1C1E),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: ListView.builder(
                      itemCount: widget.sentences.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16),
                            child: ComparedSentence(
                                widget.sentences[index].text
                                    .replaceAll('.', ''),
                                transcriptDto.transcript[index].speechToText),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 52,
                                ),
                                Text(
                                  'AI는 아래와 같이 이해했어요.',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${transcriptDto.transcript[index].speechToText}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              child: AIEmotion(
                                  transcriptDto.transcript[index].emotion)),
                          SizedBox(
                            height: 52,
                          ),
                          Center(
                            child: transcriptDto.transcript[index].isSuccess
                                ? Text(
                                    '성공',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff4169E1)),
                                  )
                                : Text(
                                    '실패',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffAC0000)),
                                  ),
                          ),
                          SizedBox(
                            height: 52,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '더 나은 스피치를 위해 아래와 같이 해볼까요?',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${transcriptDto.transcript[index].correctionProposal.proposal}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          transcriptDto.transcript[index].correctionProposal
                                      .id ==
                                  0
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    if (transcriptDto.transcript[index]
                                            .correctionProposal.id ==
                                        2 | 4) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MoviePracticePage2(
                                                    id: widget.scenarioId,
                                                    title: widget.title,
                                                    sentences: widget.sentences,
                                                    proposedRevision:
                                                        transcriptDto
                                                            .transcript[index]
                                                            .correctionProposal
                                                            .proposal,
                                                  )));
                                    } else if (transcriptDto.transcript[index]
                                            .correctionProposal.id ==
                                        1) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MoviePracticePage2(
                                                    id: widget.scenarioId,
                                                    title: widget.title,
                                                    sentences: widget.sentences,
                                                    proposedRevision:
                                                        transcriptDto
                                                            .transcript[index]
                                                            .correctionProposal
                                                            .proposal,
                                                    proposedEmotion:
                                                        randomEmotion(),
                                                  )));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("연습하러가기",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600)),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,)
                        ],
                      ),
                    ))),
          );
  }
}
