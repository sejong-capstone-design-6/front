import 'package:capstone_project/component/EmotionChip.dart';
import 'package:capstone_project/screen/BasicPracticePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmotionCard extends StatefulWidget {
  int scenarioID;
  bool? isSuccess;
  String scenario;
  String emotion;
  String title;
  EmotionCard(
      this.scenarioID, this.isSuccess, this.scenario, this.emotion, this.title);

  @override
  State<EmotionCard> createState() => _EmotionCardState();
}

class _EmotionCardState extends State<EmotionCard> {
  @override
  Widget build(BuildContext context) {
    int _scenarioID = widget.scenarioID;

    double wdth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      width: double.infinity,
      height: 128.0,
      child: Stack(
        children: [
          Container(
              width: 20,
              height: double.infinity,
              child: InkWell(
                child: Icon(
                  color: Colors.white,
                  Icons.mic_none,
                  size: 20.0,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BasicPracticePage(
                                id: _scenarioID,
                                title: widget.title,
                                text: widget.scenario,
                                emotion: widget.emotion,
                              )));
                },
              )),
          Positioned(
            left: 30,
            child: Container(
              width: wdth - 62,
              height: 128,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                color: Color.fromARGB(255, 28, 28, 30),
              ),
            ),
          ),
          Positioned(
              left: 46,
              top: 16,
              width: wdth - 94,
              child: Text(
                widget.scenario,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              )),
          Positioned(
              left: 46,
              top: 102,
              child: Row(
                children: [
                  getSuccessicon(widget.isSuccess),
                  SizedBox(
                    width: 4,
                  ),
                  getSuccess(widget.isSuccess),
                ],
              )),
          Positioned(
              width: 100,
              left: wdth - 150,
              top: 102,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EmotionChip(widget.emotion)
                ],
              ))
        ],
      ),
    );
  }

  Widget getSuccessicon(bool? value) {
    if (value == true) {
      return Icon(
        Icons.circle,
        color: Color.fromARGB(255, 65, 105, 225),
        size: 16,
      );
    } else if (value == false) {
      return Icon(
        Icons.circle,
        color: Color.fromARGB(255, 172, 0, 0),
        size: 16,
      );
    } else {
      return Text("");
    }
  }

  Widget getSuccess(bool? value) {
    if (value == false) {
      return Text(
        "실패",
        style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 172, 0, 0),
            fontWeight: FontWeight.bold),
      );
    } else if (value == true) {
      return Text(
        "성공",
        style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 65, 105, 225),
            fontWeight: FontWeight.bold),
      );
    } else {
      return Text("");
    }
  }
}
