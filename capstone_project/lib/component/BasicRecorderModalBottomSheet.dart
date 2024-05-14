import 'dart:async';
import 'dart:io';

import 'package:capstone_project/component/CompleteModal.dart';
import 'package:capstone_project/component/WaitingModal.dart';
import 'package:capstone_project/network/my_scenario_service.dart';
import 'package:capstone_project/screen/BasicEvaluationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BasicRecorderModalBottomSheet extends StatefulWidget {
  final String title;
  final String sentenceEmotion;
  final int sentenceId;
  final String sentence;

  BasicRecorderModalBottomSheet(this.title, this.sentence, this.sentenceEmotion, this.sentenceId);
  @override
  State<StatefulWidget> createState() => _RecorderModalBottomSheet();
}

class _RecorderModalBottomSheet extends State<BasicRecorderModalBottomSheet> {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  late String _filePath;
  Timer? _timer;
  int _recordDuration = 0; // 녹음 시간을 초로 계산
  bool isEvaluationDone = false;
  late int transcriptId;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<int> _checkEvaluationComplete(int sentenceId) async {
    bool status = false;
    int id = 0;
    while (!status) {
      Logger().d('Loop 1');

      if (!status) {
        await Future.delayed(Duration(seconds: 1)); // 1초 대기
      }

      var value = await myScenarioService.checkEvaluationComplete(
          sentenceId, transcriptId);
      if (value.status != null) {
        status = value.status!;
        id = value.transcriptId!;
        Logger().d(status);
        Logger().d(id);
      }
    }
    Logger().d('Evaluation complete');
    return id;
  }

  Future<void> _initializeRecorder() async {
    final status = await Permission.microphone.request();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    _filePath = '$appDocPath/${DateTime.now()}.wav';

    if (status == PermissionStatus.granted) {
      await _audioRecorder!.openRecorder();
      _startRecording();
    } else {
      throw "MicroPhone is not permitted";
    }
  }

  void _startRecording() async {
    await _audioRecorder!
        .startRecorder(toFile: _filePath, codec: Codec.pcm16WAV);
    setState(() {
      _isRecording = true;
      _recordDuration = 0;
    });
    _startTimer();
  }

  void _recallRecording() async {
    await _audioRecorder!.pauseRecorder();
    await _audioRecorder!.closeRecorder();
    _timer?.cancel();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _uploadAudio() async {
    final path = await _audioRecorder!.stopRecorder();
    final audioFile = File(path!);
    await _audioRecorder!.closeRecorder();
    _timer?.cancel();
    final dto =
        await myScenarioService.uploadVoice(widget.sentenceId, _filePath);
    transcriptId = dto.transcriptId;
    setState(() {
      _isRecording = false;
    });

    print('Recording saved to: $audioFile');
  }

  void _pauseRecording() async {
    await _audioRecorder!.pauseRecorder();
    setState(() {
      _isRecording = false;
    });
    _timer?.cancel();
  }

  void _resumeRecording() async {
    await _audioRecorder!.resumeRecorder();
    _startTimer(); // 타이머를 다시 시작
    setState(() {
      _isRecording = true;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _recordDuration++;
      });
    });
  }

  _waitVoiceFileEvaluation() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WaitingModal();
        });
    int transcriptId = await _checkEvaluationComplete(widget.sentenceId);

    Navigator.of(context).pop();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CompleteModal();
        });

    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BasicEvaluationPage(
              widget.title,
              widget.sentenceEmotion,
              widget.sentence,
              widget.sentenceId,
              transcriptId))); // 다음 페이지로 이동
    });
  }

  @override
  void dispose() {
    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    _timer?.cancel();
    super.dispose();
  }

  String formatDuration(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.maxFinite,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 2,
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Speech',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: double.maxFinite,
                  height: 42,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color(0xff7117EA)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        Text(
                          formatDuration(_recordDuration),
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          _recallRecording();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "취소",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )),
                    _isRecording
                        ? IconButton(
                            onPressed: () {
                              _pauseRecording();
                            },
                            icon: Icon(
                              Icons.pause_circle_filled,
                              size: 28,
                              color: Colors.white,
                            ))
                        : IconButton(
                            onPressed: () {
                              _resumeRecording();
                            },
                            icon: Icon(
                              Icons.not_started,
                              size: 28,
                              color: Colors.white,
                            )),
                    IconButton(
                        onPressed: () {
                          _uploadAudio()
                              .then((value) => _waitVoiceFileEvaluation());
                        },
                        icon:
                            SvgPicture.asset('assets/images/UploadButton.svg'))
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
