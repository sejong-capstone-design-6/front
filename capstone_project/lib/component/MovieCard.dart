import 'package:capstone_project/provider/movie_scenario_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        widget.url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    String thumbnailPath="assets/images/respect.png";
  if(widget.id == 1) {
    thumbnailPath="assets/images/respect.png";
  } else if(widget.id == 2) {
    thumbnailPath="assets/images/angry.png";
  } else if(widget.id == 3) {
    thumbnailPath="assets/images/crying.png";
  }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GestureDetector(
          onTap: () {
            context.read<MovieScenarioProvider>().setScenarioId(widget.id);
            context.read<MovieScenarioProvider>().setTitle(widget.title);
            context.read<MovieScenarioProvider>().SetUrl(widget.url);
            
            Navigator.pushNamed(context, '/movie_scenario');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                child: Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.asset(thumbnailPath),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                widget.movie,
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ));
  }
}
