import 'dart:convert' show json, utf8;
import 'dart:math';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;
import 'package:http/http.dart' as http;

class FacebookVideoDownloader {
//https://www.facebook.com/groups/492457711338014/permalink/929451984305249/
//^^ NOT Working ^^

//https://twitter.com/Rabipirzada/status/1420795095805317128?s=20
// downlink https://m.facebook.com/100704377989607/posts/648603423199697/?refsrc=https%3A%2F%2Fm.facebook.com%2F&refid=28&_rdr
// downlink  https://m.facebook.com/1442134249139389/posts/4673235359362579/?refsrc=https%3A%2F%2Fm.facebook.com%2F&refid=28&_rdr
  static downloadVideo(String downlink) async {
    print("working on Facebook");
    //https://www.facebook.com/100048701803103/videos/620746325553843/
    downlink = downlink.contains("www.facebook")
        ? downlink.replaceAll("www.facebook", "m.facebook")
        : downlink;
    downlink = downlink.contains("story.php")
        ? downlink
        : downlink + "?refsrc=https%3A%2F%2Fm.facebook.com%2F&refid=28&_rdr";
    print(downlink);
    var request = http.MultipartRequest('GET', Uri.parse(downlink));
    var rng = new Random();
    var uag;
    int a = rng.nextInt(2);
    if (a == 0) {
      uag = {
        "User-Agent":
            "Mozilla/5.0 (Linux; Android 5.0.2; SAMSUNG SM-G925F Build/LRX22G) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/4.0 Chrome/44.0.2403.133 Mobile Safari/537.36",
        "Accept": "*/*"
      };
    } else {
      uag = {
        "User-Agent":
            "Mozilla/5.0 (Linux; U; Android 4.1.1; en-gb; Build/KLP) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Safari/534.30",
        "Accept": "*/*"
      };
    }
    request.headers.addAll(uag);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      if (res.isNotEmpty) {
        dom.Document document = htmlparser.parse(res);
        var myDoc;
        var decoded;
        try {
          myDoc = document
              .querySelectorAll("script[type=\"application/ld+json\"]")
              .first
              .outerHtml;
          myDoc = myDoc.substring(
              myDoc.indexOf("\">{\"") + 2, myDoc.indexOf("\"}") + 2);
          myDoc = "$myDoc}";

          var temp = json.decode(myDoc);
          decoded = Uri.decodeFull(temp['contentUrl']);
          print("working try");
        } catch (e) {
          try {
            myDoc = document
                .querySelectorAll("script[type=\"application/ld+json\"]")
                .first
                .outerHtml;
            String myStr = myDoc.toString().substring(
                myDoc.toString().indexOf("\"contentUrl\":") + 14,
                myDoc.toString().indexOf(",\"publication\"") - 1);
            // print(myStr);
            // myDoc=myDoc.substring(myDoc.indexOf("\">{\"")+2,myDoc.indexOf("\"}\n</")+4);
            // var temp=json.decode(myDoc);
            decoded = Uri.decodeFull(myStr);
            decoded = decoded.toString().replaceAll("\\/", "/");
            print("working catch $decoded");
            return decoded;
          } catch (e) {
            myDoc = document
                .querySelectorAll("meta[property=\"og:video\"]")
                .last
                .attributes['content'];

            decoded = Uri.decodeFull(myDoc);
            decoded = decoded.toString().replaceAll("\\/", "/");
            print("working catch $decoded");
            return decoded;
          }
        }
      } else {
        //  return "";
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
