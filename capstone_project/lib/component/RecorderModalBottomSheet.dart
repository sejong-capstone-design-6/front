import 'dart:async';

import 'package:capstone_project/component/CompleteModal.dart';
import 'package:capstone_project/component/WaitingModal.dart';
import 'package:capstone_project/screen/BasicEvaluationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/svg.dart';

class RecorderModalBottomSheet extends StatefulWidget {
  final String title;
  final String sentenceEmotion;

  RecorderModalBottomSheet(this.title, this.sentenceEmotion);
  @override
  State<StatefulWidget> createState() => _RecorderModalBottomSheet();
}

class _RecorderModalBottomSheet extends State<RecorderModalBottomSheet> {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  bool _isWaitingForEvaluation = false;
  String? _filePath;
  Timer? _timer;
  int _recordDuration = 0; // 녹음 시간을 초로 계산

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    _filePath = '/my_recording.aac';
    await _audioRecorder!.openRecorder();
    _startRecording();
  }

  void _startRecording() async {
    await _audioRecorder!.startRecorder(toFile: _filePath);
    setState(() {
      _isRecording = true;
      _recordDuration = 0;
    });
    _startTimer();
  }

  void _stopRecording() async {
    await _audioRecorder!.stopRecorder();
    _timer?.cancel();
    setState(() {
      _isRecording = false;
    });
    if (_filePath != null) {
      print('Recording saved to: $_filePath');
    }
  }

  void _uploadAudio() async {
    await _audioRecorder!.pauseRecorder();
    await _audioRecorder!.closeRecorder();
    _timer?.cancel();
    setState(() {
      _isRecording = false;
    });
    if (_filePath != null) {
      print('Recording saved to: $_filePath');
    }
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

  _showWaitingModal() {
    Navigator.of(context).pop(); // 다이얼로그 닫기
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WaitingModal();
        });
  }

  _showCompleteModal() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CompleteModal();
        });

    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop(); // 다이얼로그 닫기
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BasicEvaluationPage(
              widget.title, widget.sentenceEmotion, 137, 34))); // 다음 페이지로 이동
    });
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
                          _stopRecording();
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
                          _uploadAudio(); //TODO 업로드 전송 로직 추가해야 함.
                          _isWaitingForEvaluation
                              ? _showWaitingModal()
                              : _showCompleteModal();
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
