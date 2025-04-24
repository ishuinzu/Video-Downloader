import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;

class LinkedInVideoDownloader {
  static getVideoId(String link) {
    var links = link.split("/status/");
    var links2;
    if (links[1].contains('?')) {
      links2 = links[1].split("?");
      return links2[0];
    } else {
      return links[1];
    }
  }

//https://twitter.com/Rabipirzada/status/1420795095805317128?s=20
  static downloadVideo(String downlink) async {
    print("working on linkedin ");
    Dio dio = Dio();
    Response response = await dio.get(downlink);
    // print(response.data);
    if (response.statusCode == 200) {
      var res = await response.data;
      if (res.isNotEmpty) {
        dom.Document document = htmlparser.parse(res);
        var myDoc;
        try {
          myDoc = document
              .querySelectorAll(
                  "video[class=\"share-native-video__node video-js\"]")
              .first
              .attributes['data-sources'];

          var temp = json.decode(myDoc)[0]['src'];
          // print(temp);
          return temp;

          ///working

        } catch (e) {}
      } else {
        //  return "";
      }
    } else {
      print("response.reasonPhrase");
      print(response.statusMessage);
    }
  }
}
