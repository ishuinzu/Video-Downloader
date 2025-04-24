import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/main.dart';
import 'package:video_downloader/ui/instagram_stories.dart';
import 'package:video_downloader/widgets/progress_dialog/src/progress_dialog.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

final GlobalKey<ScaffoldState> _scaffoldKey_insta = GlobalKey<ScaffoldState>();

class Instagram_webview extends StatefulWidget {
  const Instagram_webview({Key? key}) : super(key: key);

  @override
  _Instagram_webviewState createState() => _Instagram_webviewState();
}

class _Instagram_webviewState extends State<Instagram_webview> {
  int _progress = 0;
  ProgressDialog? pr;

  AlertDialog? alert;

//  Completer<WebViewController> _controller = Completer<WebViewController>();
  String url = "https://www.instagram.com/accounts/login/";
  double progress = 0;
  var csrftokenid, sessionid, userid;
  var mid, shbid, ig_did, shbts, ig_nrcb, urlgen;
  bool isLogedIn = false;
  var gotCookies;
  var cookieManager;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    callerfun();
    //  if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  callerfun() async {
    print("working clear cookies");
    await cookieManager.removeCookie(url);
    await cookieManager.clearCookies();
  }

  //final cookieManager = WebviewCookieManager();
  Future<String> getCookies(String siteName, String cookieName) async {
    String? CookieValue = null;

    try {
      cookieManager = WebviewCookieManager();
      gotCookies = await cookieManager.getCookies(url);
      for (var item in gotCookies) {
        print(item);
      }
      if (gotCookies != "" && gotCookies.isNotEmpty) {
        var temp = gotCookies.toString().split(";");
        for (var item in temp) {
          if (item.contains(cookieName)) {
            var temp1 = item.split("=");
            try {
              CookieValue = temp1[2];
            } catch (e) {
              CookieValue = temp1[1];
            }
            print("ASAS");
            print(cookieName);
            print(CookieValue);
            // return CookieValue;
            break;
          }
        }
        return CookieValue!;
      }
      return CookieValue!;
    }catch (e) {
      return CookieValue!;
    }
  }

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    isLogedIn = prefs.getBool('isLoggedIn')!;
    setState(() {});
  }

  //"ds_user_id=24740642071; sessionid=24740642071%3A9YVp3bILOUA3ij%3A0
  addDataToSp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('csrftoken', "$csrftokenid");
    prefs.setString('sessionid', "$sessionid");
    prefs.setString('ds_user_id', "$userid");
    prefs.setString('mid', "$mid");
    prefs.setString('shbid', "$shbid");
    prefs.setString('ig_did', "$ig_did");
    prefs.setBool('isLoggedIn', isLogedIn);
    prefs.setString('shbts', shbts);
    prefs.setString('cookies', "$gotCookies");
    prefs.setString('ig_nrcb', "$ig_nrcb");
    prefs.setString('urlgen', "$urlgen");
    print("SP Working 1");
    if (isLogedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => InstagramStories()));
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Download,
        isDismissible: false,
        showLogs: true);
    //  "https://www.instagram.com/accounts/login/"
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: theme.myAppMainColor,
          title: Text(
            getTranslated(context, "Instagram Stories")!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        key: _scaffoldKey_insta,
        backgroundColor: Colors.white,
        body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse("https://www.instagram.com/accounts/login/")),
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                  //debuggingEnabled: true,
                  )),
          onLoadStart: (controller, url) {
            setState(() {
              this.url = url.toString();
            });
          },
          onLoadStop: (controller, url) async {
            print("Here");
            print(url.toString());
            csrftokenid = await getCookies(url.toString(), "csrftoken");
            print("csrftokenid $csrftokenid");
            sessionid = await getCookies(url.toString(), "sessionid");
            mid = await getCookies(url.toString(), "mid");
            shbid = await getCookies(url.toString(), "shbid");
            ig_did = await getCookies(url.toString(), "ig_did");
            shbts = await getCookies(url.toString(), "shbts");
            ig_nrcb = await getCookies(url.toString(), "ig_nrcb");
            // urlgen=await  getCookies(url.toString(), "urlgen");
            userid = await getCookies(url.toString(), "ds_user_id");

            if (sessionid != null) {
              isLogedIn = true;
            } else {
              isLogedIn = false;
            }
            setState(() {});
            print("checking $csrftokenid $sessionid $userid");
            addDataToSp();
            final SharedPreferences prefs = await _prefs;
            setState(() {
              this.url = url.toString();
            });
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text("Please Wait... " + _progress.toString() + "% done")),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert!;
      },
    );
  }

  Future downloadfile1(String url, String savePath) async {
    print("resdatais3333 " + url.toString());
    try {
      Response response = await Dio().get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );

      print("resdatais3333 " + response.toString());

      if (response.toString() != "[]") {
        File file = File(savePath);
        var raf = file.openSync(mode: FileMode.write);
        // response.data is List<int> type
        raf.writeFromSync(response.data);
        await raf.close();
      } else {
        await pr!.hide();
        print("resdatais3333 error 99");

        if (Platform.isAndroid || Platform.isIOS) {
          print("workin 1");

          pr!.style(
              message: "Downloading",
              borderRadius: 10.0,
              backgroundColor: Colors.white,
              progressWidget: const CircularProgressIndicator(),
              elevation: 10.0,
              insetAnimCurve: Curves.easeInOut,
              messageTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600));

          await pr!.show();
        }

        Response response =
            await Dio().download(url, savePath).whenComplete(() => () async {
                  await pr!.hide();
                  showToast(
                      context,
                      getTranslated(context, "download_complete")! +
                          savePath +
                          "\"");
                  await pr!.hide();
                  Navigator.of(context).pop(alert);
                });

        print("resdatais3333 " + response.toString());
      }
    } catch (e) {
      await pr!.hide();
      // print("resdatais3333 error" + e!);

      if (Platform.isAndroid || Platform.isIOS) {
        print("workin 1");

        pr!.style(
            message: "Downloading",
            borderRadius: 10.0,
            backgroundColor: Colors.white,
            progressWidget: const CircularProgressIndicator(),
            elevation: 10.0,
            insetAnimCurve: Curves.easeInOut,
            messageTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                fontWeight: FontWeight.w600));

        await pr!.show();
      }

      Response response =
          await Dio().download(url, savePath).whenComplete(() => () async {
                await pr!.hide();
                showToast(
                    context,
                    getTranslated(context, "download_complete")! +
                        savePath +
                        "\"");
                await pr!.hide();
                Navigator.of(context).pop(alert);
              });

      print("resdatais3333 " + response.toString());
    }
  }

  int? showDownloadProgress(received, total) {
    if (total != -1) {
      var progress = (received / total * 100).toStringAsFixed(0);

      _progress = int.parse(progress);

      pr!.update(progress: _progress.toDouble());
      print(_progress.toString() + "%");
    }
  }

  void showToast(BuildContext context, var test) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(test),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
