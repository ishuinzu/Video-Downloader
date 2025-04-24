import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/utils/insta_link_download_model.dart';
import 'package:video_downloader/utils/insta_link_downloader_single.dart';
import 'package:video_downloader/utils/insta_link_downloader_video.dart';
import 'package:video_downloader/utils/utils.dart';

class InstagramLinkDownloader {
  BuildContext? context;

  downloadVideo(String link, BuildContext mContext) async {
    print("working on Instagram");
    context = mContext;
    try {

      print("urlis on paste:"+link);


      var uri = Uri.parse(link);

      var urlwi = Uri(
              scheme: uri.scheme,
              path: uri.path,
              fragment: uri.fragment,
              query: null,
              host: "instagram.com")
          .toString();
      urlwi = urlwi.replaceAll("#", "");

      String urlwithoutlettersqp = "${urlwi}?__a=1";
      if(urlwithoutlettersqp.contains("/reel/")){

        urlwithoutlettersqp = urlwithoutlettersqp.replaceAll("/reel/", "/p/");

      }

      if(urlwithoutlettersqp.contains("/tv/") ){

        urlwithoutlettersqp = urlwithoutlettersqp.replaceAll("/tv/", "/p/");

      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return bool
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      if (isLoggedIn) {
        String? userid = prefs.getString("ds_user_id");
        String? sessionid = prefs.getString("sessionid");

        Dio dio = new Dio();
        dio.options.headers['Cookie'] =
            'ds_user_id=${userid}; sessionid=${sessionid}';

        // print("asasas logged in $urlwithoutlettersqp $userid $sessionid");
        Response response = await dio.get(urlwithoutlettersqp);
       // String start = "{\"graphql\":";
       // String end = ":{\"edges\":[]}}}}";
       // final startIndex = response.toString().indexOf(start);
       // final endIndex = response.toString().indexOf(end) + end.length;
        var instaLinkDownloader;
        print(response);
      //  print(" >>${(response.toString()).substring(startIndex, endIndex)} ");

        String finalresponse =response.toString();
         //   (response.toString()).substring(startIndex, endIndex);

        try {
          instaLinkDownloader = instaLinkDownloaderFromJson(finalresponse);
          String tempDir = await iUtils.getMyDownloadDirectory();

          String halfpath = tempDir +  iUtils.nameModifier;

          // File file = File(halfpath);
          if (!Directory("${halfpath}").existsSync()) {
            new Directory(halfpath).create();
          }
          String fullPath = halfpath +
              "/" +
              iUtils.nameModifier +
              "_" +
              DateTime.now().millisecondsSinceEpoch.toString();
          // print('full path ${fullPath}');
          showToast(context!, "Download Started");
          for (int i = 0;
              i <
                  (instaLinkDownloader
                          .graphql.shortcodeMedia.edgeSidecarToChildren.edges)
                      .length;
              i++) {
            if (instaLinkDownloader.graphql.shortcodeMedia.edgeSidecarToChildren
                    .edges[i].node.isVideo ==
                true) {
              print("working if ");
              downloadfile12(
                  instaLinkDownloader.graphql.shortcodeMedia
                      .edgeSidecarToChildren.edges[i].node.videoUrl,
                  "${fullPath}$i.mp4");
            } else {
              print("working else ");
              downloadfile12(
                  instaLinkDownloader.graphql.shortcodeMedia
                      .edgeSidecarToChildren.edges[i].node.displayUrl,
                  "${fullPath}$i.jpg");
            }
          }
          showToast(context!, "Download Completed");
        } catch (e) {
          instaLinkDownloader =
              instaLinkDownloaderSingleFromJson(finalresponse);
          String tempDir = await iUtils.getMyDownloadDirectory();

          String halfpath = tempDir +  iUtils.nameModifier;

          // File file = File(halfpath);
          if (!Directory("${halfpath}").existsSync()) {
            new Directory(halfpath).create();
          }
          String fullPath = halfpath +
              "/" +
              iUtils.nameModifier +
              "_" +
              DateTime.now().millisecondsSinceEpoch.toString();
          showToast(context!, "Download Started");
          if (instaLinkDownloader.graphql.shortcodeMedia.isVideo == true) {
            instaLinkDownloader =
                instaLinkDownloaderVideoFromJson(finalresponse);
            downloadfile12(instaLinkDownloader.graphql.shortcodeMedia.videoUrl,
                "$fullPath.mp4");
          } else {
            downloadfile12(
                instaLinkDownloader.graphql.shortcodeMedia.displayUrl,
                "$fullPath.jpg");
          }
          showToast(context!, "Download Completed");
        }
      }
      else {
        Dio dio = new Dio();

        Response response = await dio.get(urlwithoutlettersqp);

        print("urlis:"+urlwithoutlettersqp);
        print(response);
        // String start = "{\"graphql\":";
        // String end = ":{\"edges\":[]}}}}";
        // final startIndex = response.toString().indexOf(start);
        // final endIndex = response.toString().indexOf(end) + end.length;
         var instaLinkDownloader;
        // print("Printing ");
        // print(" >>${(response.toString()).substring(startIndex, endIndex)} ");
        //
         String finalresponse = response.toString();
        //     (response.toString()).substring(startIndex, endIndex);

        try {
          instaLinkDownloader = instaLinkDownloaderFromJson(finalresponse);
          String tempDir = await iUtils.getMyDownloadDirectory();

          String halfpath = tempDir +  iUtils.nameModifier;

          // File file = File(halfpath);
          if (!Directory("${halfpath}").existsSync()) {
            new Directory(halfpath).create();
          }
          String fullPath = halfpath +
              "/" +
              iUtils.nameModifier +
              "_" +
              DateTime.now().millisecondsSinceEpoch.toString();
          // print('full path ${fullPath}');
          showToast(context!, "Download Started");
          for (int i = 0;
              i <
                  (instaLinkDownloader
                          .graphql.shortcodeMedia.edgeSidecarToChildren.edges)
                      .length;
              i++) {
            if (instaLinkDownloader.graphql.shortcodeMedia.edgeSidecarToChildren
                    .edges[i].node.isVideo ==
                true) {
              print("working if ");
              downloadfile12(
                  instaLinkDownloader.graphql.shortcodeMedia
                      .edgeSidecarToChildren.edges[i].node.videoUrl,
                  "${fullPath}$i.mp4");
            } else {
              print("working else ");
              downloadfile12(
                  instaLinkDownloader.graphql.shortcodeMedia
                      .edgeSidecarToChildren.edges[i].node.displayUrl,
                  "${fullPath}$i.jpg");
            }
          }
          showToast(context!, "Download Completed");
        } catch (e) {
          instaLinkDownloader =
              instaLinkDownloaderSingleFromJson(finalresponse);
          String tempDir = await iUtils.getMyDownloadDirectory();

          String halfpath = tempDir +  iUtils.nameModifier;

          // File file = File(halfpath);
          if (!Directory("${halfpath}").existsSync()) {
            new Directory(halfpath).create();
          }
          String fullPath = halfpath +
              "/" +
              iUtils.nameModifier +
              "_" +
              DateTime.now().millisecondsSinceEpoch.toString();
          showToast(context!, "Download Started");
          if (instaLinkDownloader.graphql.shortcodeMedia.isVideo == true) {
            instaLinkDownloader =
                instaLinkDownloaderVideoFromJson(finalresponse);
            downloadfile12(instaLinkDownloader.graphql.shortcodeMedia.videoUrl,
                "$fullPath.mp4");
          } else {
            downloadfile12(
                instaLinkDownloader.graphql.shortcodeMedia.displayUrl,
                "$fullPath.jpg");
          }
          showToast(context!, "Download Completed");
        }
      }
    } catch (e) {
      showToast(context!,
          "This Account is private and you are not LoggedIn in this App ");
    }
  }

  showToast(BuildContext? context, var test) {
    final scaffold = Scaffold.of(context!);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(test),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Future downloadfile12(String url, String savePath) async {
    try {
      Response response = await Dio().download(url, savePath);
      if (response.statusCode == 200) {
        await showToast(context!,
            getTranslated(context!, "download_complete")! + savePath + "\"");
      }
      print("Download Completed");
    } catch (e) {
      try {
        final downloaderUtils = DownloaderUtils(
          progressCallback: (current, total) {
            final progress = (current / total) * 100;
            if (progress % 10 == 0) {
              print('Downloading: $progress');
            }
          },
          file: File(savePath),
          progress: ProgressImplementation(),
          onDone: () async {
            await showToast(
                context!,
                getTranslated(context!, "download_complete")! +
                    savePath +
                    "\"");
          },
          deleteOnCancel: true,
        );
        await Flowder.download(url, downloaderUtils);
      } catch (e2) {
        showToast(context!,
            'Can not fetch data for the link provided. Try again with another link.');
      }
    }
  }
}
