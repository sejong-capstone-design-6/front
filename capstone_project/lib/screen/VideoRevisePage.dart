import 'package:capstone_project/component/EmotionChip.dart';
import 'package:capstone_project/component/MovieVideoPlayer.dart';
import 'package:capstone_project/component/TranscriptPageAppBar.dart';
import 'package:flutter/material.dart';

class VideoRevisePage extends StatefulWidget {
  final String title;
  final String text;
  final String? emotion;
  final String proposedRevision;
  final String url;
  final String pageRoute;

  VideoRevisePage(
      {super.key,
      required this.text,
      required this.title,
      this.emotion,
      required this.proposedRevision,
      required this.url,
      required this.pageRoute});

  @override
  State<StatefulWidget> createState() => _VideoRevisePage();
}

class _VideoRevisePage extends State<VideoRevisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: TranscriptPageAppBar(widget.title, widget.pageRoute),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Container(
          height: double.infinity,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Color(0xff1C1C1E),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Text(
                  '${widget.text}',
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              if (widget.emotion != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EmotionChip(widget.emotion!),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48,
                    ),
                    Text('아래의 교정법대로 다시 해볼거예요.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.proposedRevision}',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 48,
              ),
              MovieVideoPlayer(url: widget.url)
            ],
          ),
        ),
      ),
    );
  }
}
