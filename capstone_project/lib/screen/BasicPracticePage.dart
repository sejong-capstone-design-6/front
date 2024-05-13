import 'package:capstone_project/component/BasicAppBar.dart';
import 'package:capstone_project/component/EmotionChip.dart';
import 'package:capstone_project/component/RecorderModalBottomSheet.dart';
import 'package:flutter/material.dart';

class BasicPracticePage extends StatefulWidget {
  final int id;
  final String title;
  final String text;
  final String emotion;
  final String? proposedRevision;
  final String? proposedEmotion;

  BasicPracticePage(
      {super.key,
      required this.id,
      required this.title,
      required this.text,
      required this.emotion,
      this.proposedRevision,
      this.proposedEmotion});

  @override
  State<StatefulWidget> createState() => _BasicPracticePage();
}

class _BasicPracticePage extends State<BasicPracticePage> {
  late int transcriptId;
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
        return RecorderModalBottomSheet(
            widget.title, widget.text, widget.emotion, widget.id);
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
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text('${widget.text}'),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EmotionChip(widget.emotion),
                    ],
                  ),
                ),
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

  Widget ProposedEmotionLabel(String emotion) {
    Color color = Colors.white;
    if (emotion == "평범") {
      color = Color(0xff6A5ACD);
    } else if (emotion == "분노") {
      color = Color.fromARGB(255, 172, 0, 0);
    } else if (emotion == "웃음") {
      color = Color(0xffFFD700);
    } else if (emotion == "슬픔") {
      color = Color.fromARGB(255, 65, 105, 225);
    } else if (emotion == "놀라움") {
      color = Color(0xff32CD32);
    } else if (emotion == "두려움") {
      color = Color(0xff8E9A30);
    } else {
      color = Colors.white;
    }
    return Text(
      '$emotion',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: color),
    );
  }
}
