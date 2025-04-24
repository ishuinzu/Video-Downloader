import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StatusVideo extends StatefulWidget {
  final VideoPlayerController? videoPlayerController;
  final bool? looping;
  final String? videoSrc;
  final double? aspectRatio;

  StatusVideo({
    @required this.videoPlayerController,
    this.looping,
    this.videoSrc,
    this.aspectRatio,
    Key? key,
  }) : super(key: key);

  @override
  _StatusVideoState createState() => new _StatusVideoState();
}

class _StatusVideoState extends State<StatusVideo> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController!,
        autoInitialize: true,
        looping: widget.looping!,
        allowFullScreen: true,
        aspectRatio: widget.videoPlayerController!.value.aspectRatio,
        // autoPlay: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(errorMessage),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController!,
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }
}
