import 'package:capstone_project/component/BasicAppBar.dart';
import 'package:capstone_project/component/EmotionChip.dart';
import 'package:capstone_project/model/bringTranscriptDto.dart';
import 'package:capstone_project/network/my_scenario_service.dart';
import 'package:flutter/material.dart';

class BasicEvaluationPage extends StatefulWidget {
  final String title;
  final String sentenceEmotion;
  final int sentenceId;
  final int transcriptId;

  BasicEvaluationPage(
      this.title, this.sentenceEmotion, this.sentenceId, this.transcriptId);
  @override
  State<StatefulWidget> createState() => _BasicEvaluationPage();
}

class _BasicEvaluationPage extends State<BasicEvaluationPage> {
  bool isLoading = true;
  late BringTranscriptDto transcriptDto;

  @override
  void initState() {
    super.initState();
    myScenarioService
        .bringTranscript(widget.sentenceId, widget.transcriptId)
        .then((value) {
      transcriptDto = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Scaffold():Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: BasicAppBar(widget.title),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                      '${transcriptDto.speechToText}'),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EmotionChip(widget.sentenceEmotion),
                    ],
                  ),
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
                        '${transcriptDto.speechToText}',
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
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    "AI는 평범의 감정을 느꼈어요.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 52,
                ),
                Center(
                  child: transcriptDto.isSuccess ? Text(
                    '성공',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4169E1)),
                  ) : Text(
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
                        '${transcriptDto.correctionProposal.proposal}',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
