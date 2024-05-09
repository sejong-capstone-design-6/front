import 'package:capstone_project/component/BasicAppBar.dart';
import 'package:capstone_project/component/CompleteModal.dart';
import 'package:capstone_project/component/EmotionChip.dart';
import 'package:capstone_project/component/RecorderModalBottomSheet.dart';
import 'package:capstone_project/component/WaitingModal.dart';
import 'package:capstone_project/network/my_scenario_service.dart';
import 'package:capstone_project/provider/check_evaluation_done_provider.dart';
import 'package:capstone_project/provider/check_evaluation_done_provider.dart';
import 'package:capstone_project/screen/BasicEvaluationPage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class BasicPracticePage extends StatefulWidget {
  final int id;
  final String title;
  final String text;
  final String emotion;
  final String? proposedRevision;

  BasicPracticePage(
      {super.key,
      required this.id,
      required this.title,
      required this.text,
      required this.emotion,
      this.proposedRevision});

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
        return RecorderModalBottomSheet(widget.title, widget.emotion);
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
                    : SizedBox()
              ],
            ),
          )),
    );
  }
}
