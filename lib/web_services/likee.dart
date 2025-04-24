import 'package:flutter/cupertino.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;
import 'package:http/http.dart' as http;
import 'package:video_downloader/utils/utils.dart';

class LikeeVideoDownloader {
//https://twitter.com/Rabipirzada/status/1420795095805317128?s=20
//https://api.mitron.tv/v1/share?id=21AG2rg1PCgZbGFk2g
//https://likee.video/@Mehar_Talha786/video/6987318914785541327?lang=en&source=offcial
  static getVideoID(String link) {
    var links = link.split("=");
    print(links[1] + " " + link);
    return links[1];
  }

  static downloadVideo(String downloadlink, BuildContext context) async {
    print("working on Likee");

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://likeedownloader.com/results'));
      request.fields.addAll({
        'id': downloadlink,
      });

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        if (res.isNotEmpty) {
          dom.Document document = htmlparser.parse(res);
          var myDoc;
          myDoc = document.querySelectorAll("a")[4].attributes['href'];

          return myDoc;

          /// working
        } else {
          //  return "";
        }
      } else {
        //print(dioResponse.statusMessage);
      }
    } catch (e) {
      iUtils.showToast(context,
          'Can not fetch data for the link provided. Try again with another link.');
    }
  }
}
