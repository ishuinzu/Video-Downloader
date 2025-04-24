import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/ui/image_opener.dart';

import '../main.dart';

class GalleryImagesGrid extends StatefulWidget {
  final Directory? directory;

  // ignore: use_key_in_widget_constructors
  const GalleryImagesGrid({this.directory});

  @override
  _GalleryImagesGridState createState() => _GalleryImagesGridState();
}

class _GalleryImagesGridState extends State<GalleryImagesGrid> {
  bool isLoading = true;
  List<String> imageList = [];
  List thumbnailList = [];
  String? thumb;
  bool isSelectorEnabled = false;

  List<String> selectedToDelete = [];
  var sdkInt = 30;
  bool isAndroid11orIos = false;

  @override
  void initState() {
    super.initState;
    _setVideoList();
    getOsVersion();
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  getOsVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      sdkInt = androidInfo.version.sdkInt!;
    } else {
      sdkInt = 30;
    }
    setState(() {});
  }

  _setVideoList() async {
    imageList = widget.directory!.listSync().map((item) => item.path).where((item) => item.endsWith(".jpg")).toList(growable: false);
    //await _getAllThumbs();
  }

  @override
  Widget build(BuildContext context) {
    //  imageList = widget.directory
    //     .listSync()
    //     .map((item) => item.path)
    //     .where((item) => item.endsWith(".jpg"))
    //     .toList(growable: false);
    // print(">>${imageList.length}");

    if (imageList.isNotEmpty) {
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
                                        File mFile = File(items);
                                        if (mFile.existsSync()) {
                                          try {
                                            await mFile.delete();
                                            // ignore: empty_catches
                                          } catch (e) {}
                                          setState(() {});
                                        } else {}
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
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0).copyWith(bottom: 50),
              child: GridView.builder(
                itemCount: imageList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          if (!isSelectorEnabled) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ImageOpener(imageList[index])),
                            );
                          } else {
                            if (selectedToDelete.contains(imageList[index])) {
                              selectedToDelete.remove(imageList[index]);
                            } else {
                              selectedToDelete.add(imageList[index]);
                            }
                            setState(() {});
                          }
                        },
                        onLongPress: () {
                          if (sdkInt < 30) {
                            isSelectorEnabled = true;
                            selectedToDelete.add(imageList[index]);
                            setState(() {});
                          } else {
                            isAndroid11orIos = true;
                            setState(() {});
                          }
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                // Where the linear gradient begins and ends
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                // Add one stop for each color. Stops should increase from 0 to 1
                                stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                                colors: [
                                  // Colors are easy thanks to Flutter's Colors class.
                                  Color(0xffb7d8cf),
                                  Color(0xffb7d8cf),
                                  Color(0xffb7d8cf),
                                  Color(0xffb7d8cf),
                                  Color(0xffb7d8cf),
                                ],
                              ),
                            ),
                            child: Image.file(
                              File(imageList[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      isSelectorEnabled
                          ? InkWell(
                              onTap: () {
                                if (selectedToDelete.contains(imageList[index])) {
                                  selectedToDelete.remove(imageList[index]);
                                } else {
                                  selectedToDelete.add(imageList[index]);
                                }
                                setState(() {});
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: double.infinity,
                                  color: selectedToDelete.contains(imageList[index]) ? Colors.black.withOpacity(0.8) : Colors.black.withOpacity(0.4),
                                ),
                              ),
                            )
                          : Container(),
                      isSelectorEnabled
                          ? Checkbox(
                              value: selectedToDelete.contains(imageList[index]),
                              onChanged: (value) {
                                if (selectedToDelete.contains(imageList[index])) {
                                  selectedToDelete.remove(imageList[index]);
                                } else {
                                  selectedToDelete.add(imageList[index]);
                                }
                                setState(() {});
                              },
                              activeColor: theme.myAppMainColor,
                              side: BorderSide(color: theme.myAppMainColor, width: 3),
                            )
                          : Container(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(
          getTranslated(context, "imagescreen_text_vid")!,
          style: const TextStyle(fontSize: 18.0),
        ),
      );
    }
  }
}
