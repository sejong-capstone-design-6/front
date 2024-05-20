import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MovieCard extends StatefulWidget {
  final int id;
  final String title;
  final String movie;
  final String url;

  MovieCard(
      {super.key,
      required this.id,
      required this.title,
      required this.movie,
      required this.url});

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          VideoPlayer(_controller),
                          
                        ],
                      ),
                    )
                  : Container(),
            ),
          ),
          SizedBox(height: 8,),
          Text(widget.title, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
          SizedBox(height: 2,),
          Text(widget.movie, style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}
