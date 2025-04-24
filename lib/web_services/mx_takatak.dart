import 'dart:convert' show json, utf8;

import 'package:http/http.dart' as http;

class MxTakaTakVideoDownloader {
//https://twitter.com/Rabipirzada/status/1420795095805317128?s=20
//https://www.facebook.com/100048701803103/videos/620746325553843/
//https://chingari.io/share/post?id=60f0296a1ddd3008f883c68c
//https://sharechat.com/post/xgxNBqD?referrer=copyLink

  static downloadVideo(String downlink) async {
    print("working on Takatak");
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://mxtakatakvideodownloader.shivjagar.co.in/MXTakatak-service.php'));
    request.fields.addAll({
      'url': downlink,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var decoded = json.decode(res);

      ///Working
      return decoded['ogvideourl'];
    } else {
      print(response.reasonPhrase);
    }
  }
}
