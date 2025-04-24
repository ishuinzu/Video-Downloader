import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class JoshVideoDownloader {
  static downloadVideo(String link) async {
    var request = http.MultipartRequest('GET', Uri.parse(link));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      if (res.isNotEmpty) {
        var documents = parse(res);
        var myJson = documents
            .querySelectorAll("script[id=\"__NEXT_DATA__\"]")
            .last
            .innerHtml;
        var decoded = json.decode(myJson);
        return decoded['props']['pageProps']['detail']['data']['download_url'];

        ///Working

      } else {
        //  return "";
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
