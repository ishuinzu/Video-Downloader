import 'dart:convert' show json, utf8;

import 'package:dio/dio.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;

class MitronVideoDownloader {
//https://twitter.com/Rabipirzada/status/1420795095805317128?s=20
//https://api.mitron.tv/v1/share?id=21AG2rg1PCgZbGFk2g
  static getVideoID(String link) {
    var links = link.split("=");
    print(links[1] + " " + link);
    return links[1];
  }

  static downloadVideo(String downloadlink) async {
    print("working on Mitron");
    String url;
    if (downloadlink.contains('api.mitron.tv')) {
      url = "https://web.mitron.tv/video/${getVideoID(downloadlink)}";
    } else {
      url = downloadlink;
    }

    //  var request = http.MultipartRequest('GET', Uri.parse(url));
    Dio dio = Dio();
    Response dioResponse = await dio.get(url);

    //http.StreamedResponse response = await request.send();

    if (dioResponse.statusCode == 200) {
      var res = await dioResponse.data;
      if (res.isNotEmpty) {
        dom.Document document = htmlparser.parse(res);
        var myDoc;

        myDoc = document
            .querySelectorAll("script[id=\"__NEXT_DATA__\"]")
            .last
            .outerHtml;
        myDoc = myDoc.substring(
            myDoc.indexOf("\">{\"") + 2, myDoc.indexOf("}</") + 1);
        // myDoc="$myDoc}";
        var temp = json.decode(myDoc);
        //print(temp['props']['pageProps']['video']['videoUrl']);
        // return temp['props']['pageProps']['video']['videoUrl'].toString();

        var decoded =
            Uri.decodeFull(temp['props']['pageProps']['video']['videoUrl']);
        print(decoded);

        ///working

        return decoded;

        // var temp=json.decode(myDoc);
        // var decoded = Uri.decodeFull(temp['contentUrl']);
        //
        // return decoded;
        // var raw = Runes("\u0040context\":\"https:\/\/schema.org\",\"\u0040type\":\"SocialMediaPosting\",\"dateCreated\":\"2021-07-29T08:31:44-0700\",\"dateModified\":\"2021-07-31T00:29:57-0700\",\"identifier\":\"620746325553843:9:0\",\"articleBody\":\"Jaane Meri Jaane Maan New Version\ud83d\ude02\ud83d\ude02\",\"headline\":\"\u0637\u0644\u062d\u06c1 \u06c1\u0648\u06ba \u06cc\u0627\u0631 - Jaane Meri Jaane Maan New Version\ud83d\ude02\ud83d\ude02\",\"interactionStatistic");

        // var mess = String.fromCharCodes(raw);
        // var decoded = Uri.decodeFull(myDoc);
        // var unescape = HtmlUnescape();
        //
        //
        // var text = unescape.convert(decoded);
        // var encoded = utf8.encode(text);
        // var decoded2 = utf8.decode(encoded);
        // var temp=json.decode(decoded2);
        //print(mess);

        // final twitterModel = twitterModelFromJson(res);
        // return twitterModel.videos[0].url;

      } else {
        //  return "";
      }
    } else {
      print(dioResponse.statusMessage);
    }
  }
}
