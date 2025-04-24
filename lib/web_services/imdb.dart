import 'package:dio/dio.dart';
import 'package:video_downloader/utils/utils.dart';

class IMDBVideoDownloader {
  static downloadVideo(String url, String source) async {
    print("working on imdb");
    Response response = await Dio()
        .get(iUtils.apiUrl, queryParameters: {"url": url, "flatten": 'True'});

    /// working

    return response.data['videos'][0]['formats'][0]['url'];
    // return NewApiParserFromJson(response.toString());
  }
}
