import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class iUtils {
  static bool isYTDAvailable = true;
  static const version = '1.0';
  static const String nameModifier = "all_video_downloader_flutter";
  static const String apiUrl = "https://dlphpapis21.herokuapp.com/api/info";

  Color myAppMainColor = const Color(0xFFEF473A);

  Color gradientOne = const Color(0xFFFA2448);
  Color gradientTwo = const Color(0xFFF36926);

  setMainColor(Color color) async {
    myAppMainColor = color;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("color", color.value);
  }

  Future<Color> getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('color')) {
      return Color(prefs.getInt("color")!);
    } else {
      return myAppMainColor;
    }
  }

  static const Color myAppAccentColor = Color(0xFFC13584);
  static const Color myAppNavigationIconColor = Color(0xFFE1306C);

  static final String testAdUnitBannerId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' //add android one
      : 'ca-app-pub-3940256099942544/2934735716'; //add ios one
  static final String testAppId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544~3347511713' //add android one
      : 'ca-app-pub-3940256099942544~1458002511'; //add ios one

  static const String html = "<h3><b>How To Use?</b></h3><p>- Check the Desired Status/Story...</p><p>- Come Back to App, Click on any Image or Video to View...</p><p>- Click the Save Button...<br />The Image/Video is Instantly saved to your Galery :)</p><p>- You can also Use Multiple Saving. [to do]</p>";

  static Future<String?> getAppDetails(String detailname) async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      switch (detailname) {
        case "appname":
          {
            return packageInfo.appName.toString();
          }
        case "packedgename":
          {
            return packageInfo.packageName.toString();
          }
        case "version":
          {
            return packageInfo.version.toString();
          }
        case "buildnumber":
          {
            return packageInfo.buildNumber.toString();
          }
        default:
          {
            return "all_video_downloader_flutter";
          }
      }
    });
    return null;
  }

  static showToast(BuildContext context, var test) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(test),
        ),
        action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  static final supportedLangList = ["English", "Hindi", "Arabic"];

  static getMyDownloadDirectory() async {
    if (Platform.isAndroid) {
      return "/storage/emulated/0/Download/";
    } else if (Platform.isIOS) {
      Directory mPath = await getApplicationDocumentsDirectory();
      return mPath.path + "/";
    }
  }

  static bool isConnected = false;

  static checkingInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
  }
}
