import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class MovieVideoPlayer extends StatefulWidget {
  final String url;

  MovieVideoPlayer({super.key, required this.url});

  @override
  State<MovieVideoPlayer> createState() => _MovieVideoPlayer();
}

class _MovieVideoPlayer extends State<MovieVideoPlayer> {
  late VideoPlayerController _controller;
  double? aspectRatio;
  double progress = 0;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller =  VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize();
    _controller.setPlaybackSpeed(1);
    played();

    _controller.addListener(() async {
      int max = _controller.value.duration.inSeconds;
      setState(() {
        aspectRatio = _controller.value.aspectRatio;
        position = _controller.value.position;
        progress = (position.inSeconds / max * 100).isNaN
            ? 0
            : position.inSeconds / max * 100;
      });
    });
  }

  void played() => _controller.play();

  void stoped() => _controller.pause();

  void seekTo(int value) {
    int add = position.inSeconds + value;

    _controller.seekTo(Duration(seconds: add < 0 ? 0 : add));
  }

    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller),
                Positioned(
                  bottom: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            seekTo(-10);
                          },
                          child: const SizedBox(
                            width: 30,
                            child: Icon(
                              Icons.replay_10_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            if (_controller.value.isPlaying) {
                              stoped();
                            } else {
                              played();
                            }
                          },
                          child: SizedBox(
                            width: 30,
                            child: Icon(
                              _controller.value.isPlaying
                                  ? Icons.stop
                                  : Icons.play_arrow_rounded,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            seekTo(10);
                          },
                          child: const SizedBox(
                            width: 30,
                            child: Icon(
                              Icons.forward_10_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _controller.value.position.toString().substring(2, 7),
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          " / ${_controller.value.duration.toString().substring(2, 7)}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
