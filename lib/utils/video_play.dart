import 'dart:io';

import 'package:video_downloader/utils/utils.dart';
import 'package:video_downloader/utils/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../main.dart';

class PlayStatus extends StatefulWidget {
  final String videoFile;

  PlayStatus(this.videoFile);

  @override
  _PlayStatusState createState() => new _PlayStatusState();
}

class _PlayStatusState extends State<PlayStatus> {
  @override
  void initState() {
    super.initState();
    print('Video file you are looking for :' + widget.videoFile);
  }

  void dispose() {
    super.dispose();
  }

  void _onLoading(bool t, String str) {
    if (t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator()),
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Great, Saved in Gallary",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text(str,
                              style: TextStyle(
                                fontSize: 16.0,
                              )),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text("FileManager/Downloads > ${iUtils.nameModifier}",
                              style: TextStyle(
                                  fontSize: 16.0, color: theme.myAppMainColor)),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            child: Text("Close"),
                            color: theme.myAppMainColor,
                            textColor: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //
      //     elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     color: Colors.white,
      //     icon: Icon(
      //       Icons.close,
      //       color: Colors.white,
      //     ),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          // height: 200,
          child: StatusVideo(
            videoPlayerController:
                VideoPlayerController.file(File(widget.videoFile)),
            looping: true,
            aspectRatio: 1,
            videoSrc: widget.videoFile,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: new FloatingActionButton(
            backgroundColor: theme.myAppMainColor,
            child: Icon(Icons.save),
            onPressed: () async {
              //   _onLoading(true, "");

              File originalVideoFile = File(widget.videoFile);
              String directory = await iUtils.getMyDownloadDirectory();
              if (!Directory("$directory/${iUtils.nameModifier}/")
                  .existsSync()) {
                Directory("$directory/${iUtils.nameModifier}/")
                    .createSync(recursive: true);
              }

              String curDate = DateTime.now().toString();
              String newFileName =
                  "$directory/${iUtils.nameModifier}/VIDEO-$curDate.mp4";
              print(originalVideoFile);
              print(newFileName);
              await originalVideoFile.copy(newFileName);

              // _onLoading(false,"If Video not available in gallary\n\nYou can find all videos at");
            }),
      ),
    );
  }
}
