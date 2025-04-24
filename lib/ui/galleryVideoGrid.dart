import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/utils/videoPlaying.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../main.dart';

class GalleryVideosGrid extends StatefulWidget {
  final Directory? directory;

  const GalleryVideosGrid({this.directory});

  @override
  _GalleryVideosGridState createState() => _GalleryVideosGridState();
}

class _GalleryVideosGridState extends State<GalleryVideosGrid> {
  bool isLoading = true;
  List<dynamic>? videoList;
  String? thumb;
  var thumbnailList = [];
  int counter = 0;
  bool isSelectorEnabled = false;
  List<String> selectedToDelete = [];
  var sdkInt = 30;
  bool isAndroid11orIos = false;

  getOsVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      sdkInt = androidInfo.version.sdkInt!;
    } else {
      sdkInt = 30;
    }
    setState(() {});
  }

  Future<String?> _getImage(videoPathUrl) async {
    counter++;

    return await VideoThumbnail.thumbnailFile(
      video: videoPathUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 50,
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    _setVideoList();
    getOsVersion();
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  _getAllThumbs() async {
    for (int i = 0; i < videoList!.length; i++) {
      try {
        print(">>>>$i ${videoList![i]}");
        thumbnailList.add(await _getImage(videoList![i]));
        setState(() {});
      } catch (e) {
        e.toString();
      }
    }
    isLoading = false;
    setState(() {});
  }

  _setVideoList() async {
    videoList = widget.directory!.listSync().map((item) => item.path).where((item) => item.endsWith(".mp4")).toList(growable: false);
    print(videoList!.length);
    print("videoList.length^^^^");
    await _getAllThumbs();
  }

  @override
  Widget build(BuildContext context) {
    if (counter == videoList!.length) {
      isLoading = false;
    }

    if (!isLoading) {
      if (videoList!.isNotEmpty) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              isSelectorEnabled
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: theme.myAppMainColor.withOpacity(0.2),
                            border: Border.all(
                              color: theme.myAppMainColor.withOpacity(0.4),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Are you sure you want to delete",
                                style: TextStyle(
                                  color: theme.myAppMainColor,
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        isSelectorEnabled = false;
                                        selectedToDelete.clear();
                                        setState(() {});
                                      },
                                      child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Icon(
                                            Icons.close,
                                            color: theme.myAppMainColor,
                                          ))),
                                  // SizedBox(width: 20,),
                                  InkWell(
                                      onTap: () async {
                                        for (var items in selectedToDelete) {
                                          await File(items).delete();
                                          setState(() {});
                                        }
                                        selectedToDelete.clear();
                                        isSelectorEnabled = false;
                                        await _setVideoList();
                                        setState(() {});
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Center(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(color: theme.myAppMainColor),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              isAndroid11orIos
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 40,
                        decoration: BoxDecoration(
                            color: theme.myAppMainColor.withOpacity(0.2),
                            border: Border.all(
                              color: theme.myAppMainColor.withOpacity(0.4),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: Text(
                                    "Android 11 don't support Deletion You Have to Delete it manually located in \n"
                                    "${widget.directory}",
                                    style: TextStyle(
                                      color: theme.myAppMainColor,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    isAndroid11orIos = false;
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Icon(
                                        Icons.close,
                                        color: theme.myAppMainColor,
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: GridView.builder(
                  itemCount: thumbnailList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    return buildList(context, index);
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(
          child: Text(
            getTranslated(context, "gallery_sorrytext_vid")!,
            style: const TextStyle(fontSize: 18.0),
          ),
        );
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  buildList(BuildContext context, int index) {
    return true
        ? Stack(
            children: [
              InkWell(
                onTap: () {
                  if (!isSelectorEnabled) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoPlaying(videoUrl: videoList![index])),
                    );
                  } else {
                    if (selectedToDelete.contains(videoList![index])) {
                      selectedToDelete.remove(videoList![index]);
                    } else {
                      selectedToDelete.add(videoList![index]);
                    }
                    setState(() {});
                  }
                },
                onLongPress: () {
                  if (sdkInt < 30) {
                    isSelectorEnabled = true;
                    selectedToDelete.add(videoList![index]);
                    setState(() {});
                  } else {
                    isAndroid11orIos = true;
                    setState(() {});
                  }
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(color: theme.myAppMainColor.withOpacity(0.2)),
                    child: thumbnailList[index] != null
                        ? Stack(
                            children: [
                              SizedBox(
                                width: (MediaQuery.of(context).size.width - 20) / 3,
                                height: (MediaQuery.of(context).size.width - 20) / 3,
                                child: Image.file(
                                  File(thumbnailList[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 40,
                                  )),
                            ],
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
              isSelectorEnabled
                  ? InkWell(
                      onTap: () {
                        if (selectedToDelete.contains(videoList![index])) {
                          selectedToDelete.remove(videoList![index]);
                        } else {
                          selectedToDelete.add(videoList![index]);
                        }
                        setState(() {});
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          color: selectedToDelete.contains(videoList![index]) ? Colors.black.withOpacity(0.8) : Colors.black.withOpacity(0.4),
                        ),
                      ),
                    )
                  : Container(),
              isSelectorEnabled
                  ? Checkbox(
                      value: selectedToDelete.contains(videoList![index]),
                      onChanged: (value) {
                        if (selectedToDelete.contains(videoList![index])) {
                          selectedToDelete.remove(videoList![index]);
                        } else {
                          selectedToDelete.add(videoList![index]);
                        }
                        setState(() {});
                      },
                      activeColor: theme.myAppMainColor,
                      side: BorderSide(color: theme.myAppMainColor, width: 3),
                    )
                  : Container(),
            ],
          )
        : const CircularProgressIndicator();
  }
}
