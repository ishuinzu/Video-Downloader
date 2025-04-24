import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_downloader/ui/download_page_main.dart';
import 'package:video_downloader/ui/secret_companion.dart';
import 'package:video_downloader/ui/vault.dart';
import '../main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int mindex = 0;
  List<Widget> myPages = [
    const DownloadPageMain(),
    const SecretCompanionMain(),
    const VaultScreen(),
  ];

  // BannerAd _bannerAd;
  bool connected = false;
  BannerAd? myBanner;
  AdWidget? adWidget;
  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  @override
  void initState() {
    getExternalStorage();
    checkingInternet();
    super.initState();
  }

  getExternalStorage() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      if (sdkInt! >= 30) {
        await Permission.manageExternalStorage.request();
      }
    }
  }

  @override
  void dispose() {
    _anchoredBanner?.dispose();
    super.dispose();
  }

  checkingInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connected = true;

        setState(() {});
      }
    } on SocketException catch (_) {
      //print('not connected');
      connected = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: theme.myAppMainColor));
    if (!_loadingAnchoredBanner) {
      _loadingAnchoredBanner = true;
      _createAnchoredBanner(context);
    }

    return Scaffold(
      body: myPages[mindex],
      bottomNavigationBar: SizedBox(
        height: connected ? 125 : 75,
        child: Column(
          children: [
            CurvedNavigationBar(
              animationCurve: Curves.ease,
              backgroundColor: theme.myAppMainColor.withOpacity(0.05),
              color: theme.myAppMainColor,
              buttonBackgroundColor: theme.myAppMainColor,
              items: <Widget>[
                SizedBox(
                    width: 40,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset("assets/settings_icons/download.png"),
                    )),
                SizedBox(
                    width: 40,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset("assets/settings_icons/moreapps_white.png"),
                    )),
                SizedBox(
                    width: 40,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset("assets/settings_icons/vault_white.png"),
                    )),
              ],
              onTap: (index) {
                setState(() {
                  mindex = index;
                });
              },
            ),
            (connected)
                ? Container(
                    alignment: Alignment.center,
                    child: _anchoredBanner != null ? AdWidget(ad: _anchoredBanner!) : Container(),
                    height: 50,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size = await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    myBanner = BannerAd(
      adUnitId: getBannerAdUnitId()!,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return myBanner!.load();
  }

  String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  String? getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }

  String? getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return null;
  }
}
