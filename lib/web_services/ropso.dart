import 'package:dio/dio.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;

class RoposoVideoDownloader {
//https://twitter.com/Rabipirzada/status/1420795095805317128?s=20
//https://www.facebook.com/100048701803103/videos/620746325553843/
  static downloadVideo(String downlink) async {
    print("working on Roposo");
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
              .querySelectorAll("meta[property=\"og:video\"]")
              .first
              .attributes['content'];

          return myDoc;

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
