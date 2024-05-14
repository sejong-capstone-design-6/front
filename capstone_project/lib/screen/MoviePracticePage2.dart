import 'package:capstone_project/component/BasicAppBar.dart';
import 'package:capstone_project/component/PropsoedEmotionLabel.dart';
import 'package:capstone_project/component/WaitingModal.dart';
import 'package:capstone_project/model/bringScenarioSentenceDto.dart';
import 'package:flutter/material.dart';

class MoviePracticePage2 extends StatefulWidget {
  final int id;
  final String title;
  final List<Sentence> sentences;
  final String? proposedRevision;
  final String? proposedEmotion;

  MoviePracticePage2({
    super.key,
    required this.id,
    required this.title,
    required this.sentences,
    this.proposedEmotion,
    this.proposedRevision
  });

  @override
  State<StatefulWidget> createState() => _MoviePracticePage2();
}

class _MoviePracticePage2 extends State<MoviePracticePage2> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showModalBottomSheet();
    });
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: false,
      builder: (context) {
        return WaitingModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: BasicAppBar(widget.title)),
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
              children: [
                Expanded(child: ListView.builder(
                  itemCount: widget.sentences.length,
                  itemBuilder: (context, index){
                  return ListTile(
                            title: Text(
                              widget.sentences[index].speaker,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                                widget.sentences[index].text,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          );
                })),
                widget.proposedRevision != null
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 48,
                            ),
                            Text(
                              '아래의 교정법대로 다시 해볼거예요.',
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
                              '${widget.proposedRevision}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 48,
                ),
                widget.proposedEmotion != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Center(
                          child: ProposedEmotionLabel(widget.proposedEmotion!),
                        ))
                    : SizedBox()
              ],
            ),
          )),
    );
  }
}