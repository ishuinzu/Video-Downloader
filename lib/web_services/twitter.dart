import 'package:http/http.dart' as http;
import 'package:video_downloader/models/twitter_model.dart';

class TwitterVideoDownloader {
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
  static downloadVideo(String link) async {
    var url =
        'https://twittervideodownloaderpro.com/twittervideodownloadv2/index.php';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({'id': getVideoId(link)});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      if (res.isNotEmpty) {
        final twitterModel = twitterModelFromJson(res);
        return twitterModel.videos[0].url;

        ///working

      } else {
        return "";
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
