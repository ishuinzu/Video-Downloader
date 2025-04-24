import 'package:dio/dio.dart';
import 'package:video_downloader/utils/utils.dart';

class ESPNVideoDownloader {
  static downloadVideo(String url, String source) async {
    print("working on espn");
    Response response = await Dio()
        .get(iUtils.apiUrl, queryParameters: {"url": url, "flatten": 'True'});

    /// working

    return response.data['videos'][0]['url'];
    // return NewApiParserFromJson(response.toString());
  }
}
