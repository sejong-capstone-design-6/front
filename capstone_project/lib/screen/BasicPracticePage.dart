import 'package:capstone_project/component/EmotionChip.dart';
import 'package:flutter/material.dart';

class BasicPracticePage extends StatefulWidget {
  int id;
  String title;
  String text;
  String emotion;
  String? proposedRevision;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EmotionChip(widget.emotion),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
