import 'dart:convert' show json, utf8;

import 'package:http/http.dart' as http;

class ChingariVideoDownloader {
//https://twitter.com/Rabipirzada/status/1420795095805317128?s=20
//https://www.facebook.com/100048701803103/videos/620746325553843/
//https://chingari.io/share/post?id=60f0296a1ddd3008f883c68c

  // https://mxshorts.akamaized.net/video/20000D5Eqy/download/1/h265_main_360.mp4
  // /Users/aneeq/Library/Developer/CoreSimulator/Devices/EBF2D5EA-1091-4ADF-94FE-61D4F5635B1E/data/Containers/Data/Application/CA839366-B428-453E-839D-630A2AFBFD35/Documents/all_video_downloader_flutter/all_video_downloader_flutter_takatak_1629524614774.mp4

  static downloadVideo(String downlink) async {
    print("working on Chingariiii");
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.chingari.io/post/post_details/${downlink.split("=")[1]}'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      if (res.isNotEmpty) {
        try {
          Map<String, dynamic> jsonResponse = json.decode(res);
          var temp = jsonResponse['data']['mediaLocation']["transcoded"];
          var matag;
          if (temp.toString().contains("p1024")) {
            matag = temp["p1024"];
          } else if (temp.oString().contains("p720")) {
            matag = temp["p720"];
          } else if (temp.toString().contains("p480")) {
            matag = temp["p480"];
          }
          return "https://media.chingari.io" + matag;

          ///working

        } catch (e) {
          print("Cingari download error" + e.toString());
        }
      } else {
        //  return "";
      }
    } else {
      print("response.reasonPhrase");
      // print(response.statusMessage);
    }
  }
}
