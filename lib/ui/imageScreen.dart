import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/ui/viewphotos.dart';

final Directory _photoDirand11_business = Directory('/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses');
final Directory _photoDirand11_whatsapp = Directory('/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

final Directory _photoDirand_business = Directory('/storage/emulated/0/WhatsApp Business/Media/.Statuses');

final Directory _photoDirand_whatsapp = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class ImageScreen extends StatefulWidget {
  @override
  ImageScreenState createState() => ImageScreenState();
}

class ImageScreenState extends State<ImageScreen> {
  List dataList = [];

  @override
  void initState() {
    super.initState();
    try {
      getStatusData();
    } catch (e) {
      e.toString();
    }
  }

  getStatusData() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      print(sdkInt);
      if (sdkInt! < 30) {
        if (Directory(_photoDirand_whatsapp.absolute.path).existsSync() || Directory(_photoDirand_business.absolute.path).existsSync()) {
          if (Directory(_photoDirand_whatsapp.absolute.path).existsSync()) {
            var imageList = Directory(_photoDirand_whatsapp.absolute.path).listSync().map((item) => item.path).where((item) => item.endsWith(".jpg")).toList(growable: false);
            if (imageList.isNotEmpty) {
              dataList.addAll(imageList);
            }
          }
          if (Directory(_photoDirand_business.absolute.path).existsSync()) {
            var imageListBusiness = Directory(_photoDirand_business.absolute.path).listSync().map((item) => item.path).where((item) => item.endsWith(".jpg")).toList(growable: false);

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
      } else {
        if (Directory(_photoDirand11_whatsapp.absolute.path).existsSync() || Directory(_photoDirand11_business.absolute.path).existsSync()) {
          if (Directory(_photoDirand11_whatsapp.absolute.path).existsSync()) {
            var imageList = Directory(_photoDirand11_whatsapp.absolute.path).listSync().map((item) => item.path).where((item) => item.endsWith(".jpg")).toList(growable: false);

            if (imageList.isNotEmpty) {
              dataList.addAll(imageList);
            }
          }

          if (Directory(_photoDirand11_business.absolute.path).existsSync()) {
            var imageListBusiness = Directory(_photoDirand11_business.absolute.path).listSync().map((item) => item.path).where((item) => item.endsWith(".jpg")).toList(growable: false);

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
  Widget build(BuildContext context) {
    print(dataList.length);
    if (dataList.length > 0) {
      //
      return Container(
          margin: const EdgeInsets.all(8.0).copyWith(bottom: 50),
          child: MasonryGridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              String imgPath = dataList[index];
              return Material(
                elevation: 8.0,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPhotos(imgPath)));
                  },
                  child: Hero(
                      tag: imgPath,
                      child: Image.file(
                        File(imgPath),
                        fit: BoxFit.cover,
                      )),
                ),
              );
            },
          ));
    } else {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Text(
                  getTranslated(context, 'imagescreen_text_vid')!,
                  style: const TextStyle(fontSize: 18.0),
                )),
          ),
        ),
      );
    }
  }
}
