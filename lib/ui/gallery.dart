import 'dart:async';
import 'dart:io';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/ui/galleryImageGrid.dart';
import 'package:video_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../main.dart';
import 'galleryVideoGrid.dart';

GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

class GalleryVideos extends StatefulWidget {
  const GalleryVideos({Key? key}) : super(key: key);

  @override
  GalleryVideosScreenState createState() => GalleryVideosScreenState();
}

class GalleryVideosScreenState extends State<GalleryVideos> {
  bool isLoading = true;
  // ignore: prefer_typing_uninitialized_variables
  var videoList;
  Directory _videoSaveDir = Directory("");

  setDirectory() async {
    Directory? iosDirectory;
    if (Platform.isIOS) {
      iosDirectory = await getApplicationDocumentsDirectory();
    }
    _videoSaveDir = Platform.isAndroid ? Directory('/storage/emulated/0/Download/' + iUtils.nameModifier + '/') : Directory(iosDirectory!.path + "/" + iUtils.nameModifier + '/');
  }

  @override
  // ignore: must_call_super
  void initState() {
    setDirectory();
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory(_videoSaveDir.path).existsSync()) {
      return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, "Gallery")!),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Center(
            child: Text(
              getTranslated(context, "gallery_novids")!,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      );
    } else {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey2,
          appBar: AppBar(
            title: const Text(
              "Gallery",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: theme.myAppMainColor,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: theme.myAppMainColor,
              indicator: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)), color: Colors.white),
              tabs: const [
                SizedBox(
                    height: 40,
                    child: Center(
                        child: Text(
                      "Images",
                    ))),
                SizedBox(
                    height: 40,
                    child: Center(
                        child: Text(
                      "Videos",
                    ))),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GalleryImagesGrid(directory: _videoSaveDir),
              GalleryVideosGrid(
                directory: _videoSaveDir,
              ),
            ],
          ),
        ),
      );
    }
  }
}
