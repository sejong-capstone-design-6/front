import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  void onClicked() {
    setState(() {});
  }

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
  }

  bool _onTouch = false;
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        VideoPlayer(_controller),
                        ClosedCaption(text: null),
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            playedColor: Colors.red,
                          ),
                        ),
                        Visibility(
                          visible: _onTouch,
                          child: Container(
                            color: Colors.grey.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: FloatingActionButton(onPressed: () {
                              _timer?.cancel();
                              setState(
                                () {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                },
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ),
    );
  }
}
