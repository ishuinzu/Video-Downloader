import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;
import 'package:http/http.dart' as http;

class TiktokVideoDownloader {
//https://twitter.com/Rabipirzada/status/1420795095805317128?s=20
  static downloadVideo(String link) async {
    var headers = {
      'cache-contro': 'no-cache',
      'content-type': 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW',
      'origin': 'https://tiktokdownload.online',
      'postman-token': 'c866af6b-b900-cf0f-2043-1296b0e5362a',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:1.7.3) Gecko/20041001 Firefox/0.10.1',
      'x-http-method-override': 'POST',
      'x-ic-request': 'true',
      'x-requested-with': 'XMLHttpRequest'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://tiktokdownload.online/results'));
    request.fields.addAll({
      'ic-request': 'true',
      'id': '$link',
      // 'id': 'https://vm.tiktok.com/ZGJDndFM6/',
      'ic-element-id': 'main_page_form',
      'ic-id': '1',
      'ic-target-id': 'active_container',
      'ic-trigger-id': 'main_page_form',
      'token': '493eaebbf47aa90e1cdfa0f8faf7d04cle0f45a38aa759c6a13fea91d5036dc3b',
      'ic-current-url': '',
      'ic-select-from-response': '#id4fbbea',
      '_method': 'nPOST'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      if (res.isNotEmpty) {
        dom.Document document = htmlparser.parse(res);
        var myDoc;
        try {

          // var ttt = document.querySelectorAll("a");
          // print("ttt1"+ttt[5].attributes['href']!);
          // print(ttt[6].attributes['href']);
          // print(ttt[7].attributes['href']);
          // print(ttt[8].attributes['href']);

          myDoc = document.querySelectorAll("a")[5].attributes['href'];
          print(myDoc);
          return myDoc;

          ///working

        } catch (e) {}
      } else {
        //  return "";
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
