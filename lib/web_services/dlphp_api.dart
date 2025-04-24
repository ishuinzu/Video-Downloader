
import 'package:video_downloader/models/newModel.dart';
import 'package:video_downloader/utils/utils.dart';
import 'package:dio/dio.dart';

class DlPhpApi {
  static downloadVideo(String url, String source) async {
    Response response = await Dio()
        .get(iUtils.apiUrl, queryParameters: {"url": url, "flatten": 'True'});
    print(response);

    ///working

    return NewApiParserFromJson(response.toString());
  }
}
