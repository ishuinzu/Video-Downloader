import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/res.dart';
import 'package:video_downloader/utils/video_play.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final Directory _videoDirand11_business = Directory(
    '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses');
final Directory _videoDirand11_whatsapp = Directory(
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

final Directory _videoDirand_business =
    Directory('/storage/emulated/0/WhatsApp Business/Media/.Statuses');

final Directory _videoDirand_whatsapp =
    Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  dynamic asd = "sd";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const VideoGrid();
  }
}

class VideoGrid extends StatefulWidget {

  const VideoGrid({Key? key}) : super(key: key);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  List dataList = [];

  Future<String?> _getImage(videoPathUrl) async {
    print("^>^>^>^");
    return await VideoThumbnail.thumbnailFile(
      video: videoPathUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 50,
    );
  }

  getStatusData() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      print(sdkInt);
      if (sdkInt! < 30) {
        if (Directory(_videoDirand_whatsapp.absolute.path).existsSync() ||
            Directory(_videoDirand_business.absolute.path).existsSync()) {

          if(Directory(_videoDirand_whatsapp.absolute.path).existsSync()) {
            var imageList = Directory(_videoDirand_whatsapp.absolute.path)
                .listSync()
                .map((item) => item.path)
                .where((item) => item.endsWith(".mp4"))
                .toList(growable: false);
            dataList.addAll(imageList);
          }
          if(Directory(_videoDirand_business.absolute.path).existsSync()){
          var imageListBusiness = Directory(_videoDirand_business.absolute.path)
              .listSync()
              .map((item) => item.path)
              .where((item) => item.endsWith(".mp4"))
              .toList(growable: false);

          dataList.addAll(imageListBusiness);
          if (imageListBusiness.isNotEmpty) {

          }}
        } else {
          return Center(
            child: Text(
              getTranslated(context, 'imagescreen_install')!,
              style: const TextStyle(fontSize: 18.0),
            ),
          );
        }
      } else {
        if (Directory(_videoDirand11_whatsapp.absolute.path).existsSync() ||
            Directory(_videoDirand11_business.absolute.path).existsSync()) {
          if (Directory(_videoDirand11_business.absolute.path).existsSync()) {
            var imageList = Directory(_videoDirand11_business.absolute.path)
                .listSync()
                .map((item) => item.path)
                .where((item) => item.endsWith(".mp4"))
                .toList(growable: false);
            if (imageList.isNotEmpty) {
              dataList.addAll(imageList);
            }
          }

          if (Directory(_videoDirand11_whatsapp.absolute.path).existsSync()) {
            var imageListBusiness =
                Directory(_videoDirand11_whatsapp.absolute.path)
                    .listSync()
                    .map((item) => item.path)
                    .where((item) => item.endsWith(".mp4"))
                    .toList(growable: false);

            if (imageListBusiness.isNotEmpty) {
              dataList.addAll(imageListBusiness);
            }
          }
        } else {
          return Center(
            child: Text(
              getTranslated(context, 'imagescreen_install')!,
              style: const TextStyle(fontSize: 18.0),
            ),
          );
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getStatusData();
  }

  @override
  Widget build(BuildContext context) {
    if (dataList != null) {
      if (dataList.isNotEmpty) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0)
              .copyWith(bottom: 50),
          child: GridView.builder(
            itemCount: dataList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlayStatus(dataList[index])),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
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
                    child: FutureBuilder(
                        future: _getImage(dataList[index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Image.file(
                                File(snapshot.data.toString()),
                                fit: BoxFit.cover,
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          } else {
                            return SizedBox(
                              height: 280.0,
                              child: Image.asset(Res.video_loader),
                            );
                          }
                        }),
                    //new cod
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Center(
          child: Text(
            getTranslated(context, 'gallery_sorrytext_vid')!,
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
}
