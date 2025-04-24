import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlaying extends StatefulWidget {
  final videoUrl;

  const VideoPlaying({this.videoUrl});

  @override
  _VideoPlayingState createState() => _VideoPlayingState();
}

class _VideoPlayingState extends State<VideoPlaying> {
  // FlickManager? flickManager;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController:
            VideoPlayerController.file(File(widget.videoUrl)),
        autoInitialize: true,
        looping: true,
        allowFullScreen: true,
        aspectRatio: 1,
        // autoPlay: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(errorMessage),
          );
        });
  }

  @override
  void dispose() {
    _chewieController!.pause();
    _chewieController!.dispose();
    super.dispose();
  }

  List<dynamic> videos = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        return  true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chewie(
                    controller: _chewieController!,
                  ),
                ],
              ),
            ),
            Positioned.fill(
                top: 30,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
