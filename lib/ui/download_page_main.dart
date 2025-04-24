import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:filesize/filesize.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/models/newModel.dart';
import 'package:video_downloader/utils/utils.dart';
import 'package:video_downloader/web_services/chingari.dart';
import 'package:video_downloader/web_services/dlphp_api.dart';
import 'package:video_downloader/web_services/espn.dart';
import 'package:video_downloader/web_services/facebook.dart';
import 'package:video_downloader/web_services/imdb.dart';
import 'package:video_downloader/web_services/instagram.dart';
import 'package:video_downloader/web_services/josh.dart';
import 'package:video_downloader/web_services/likee.dart';
import 'package:video_downloader/web_services/linkedin.dart';
import 'package:video_downloader/web_services/mitron.dart';
import 'package:video_downloader/web_services/moj.dart';
import 'package:video_downloader/web_services/mx_takatak.dart';
import 'package:video_downloader/web_services/ropso.dart';
import 'package:video_downloader/web_services/sharechat.dart';
import 'package:video_downloader/web_services/tiktok.dart';
import 'package:video_downloader/web_services/twitter.dart';
import 'package:video_downloader/widgets/progress_dialog/src/progress_dialog.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_downloader/utils/my_icons_list.dart';

class DownloadPageMain extends StatefulWidget {
  const DownloadPageMain({Key? key}) : super(key: key);

  @override
  _DownloadPageMainState createState() => _DownloadPageMainState();
}

class _DownloadPageMainState extends State<DownloadPageMain> {
  ProgressDialog? pr;
  AlertDialog? alert;
  NewApiParser? apiParser;
  bool showBottomSheetForDownload = false;
  StreamSubscription? _intentDataStreamSubscription;
  TextEditingController? downloadUrlController = TextEditingController();

  @override
  void dispose() {
    _intentDataStreamSubscription!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    iUtils.checkingInternet();
    iUtils.checkingInternet();
    setState(() {});
    _intentDataStreamSubscription = ReceiveSharingIntent.getTextStream().listen((String value) async {
      downloadUrlController!.text = value;
      if (iUtils.isConnected) {
        getDownloadLinkData();
      }
    }, onError: (err) {
      //print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      if (value != null) {
        downloadUrlController!.text = value;
        value != "" ? getDownloadLinkData() : null;
      }
    });
  }

  actionBackButton() {}

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
    pr!.style(
        message: getTranslated(context, "download_downloadingtext")!,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircularProgressIndicator(),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: const TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: theme.myAppMainColor,
          centerTitle: false,
          actions: [
            Image.asset(
              'assets/images/noads.png',
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 24.0),
            Image.asset(
              'assets/images/video.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 16.0),
            Image.asset(
              'assets/images/menu.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 16.0),
          ],
          title: Text(
            "Home",
            style: GoogleFonts.allerta(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              letterSpacing: 0.5,
            ),
          ),
        ),
        body: Container(
          color: theme.myAppMainColor.withOpacity(0.05),
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 64,
                      decoration: BoxDecoration(
                        color: theme.myAppMainColor,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 15,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 44,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.cloud_download_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    "Download",
                                    style: GoogleFonts.allerta(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.face_retouching_natural_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: theme.myAppMainColor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.apps_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: theme.myAppMainColor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFCDD),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 15,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      getTranslated(context, 'how_to_download?')!,
                                      style: GoogleFonts.allerta(
                                        color: const Color(0xFFB38E34),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17.0,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.keyboard_double_arrow_right_rounded,
                                        size: 16,
                                        color: Color(0xFFBC9A46),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        getTranslated(context, 'copy_link')!,
                                        style: GoogleFonts.allerta(
                                          color: const Color(0xFFBC9A46),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  customListTile(number: getTranslated(context, '01'), description: getTranslated(context, 'Open_share_icons')),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.keyboard_double_arrow_right_rounded,
                                        size: 16,
                                        color: Color(0xFFBC9A46),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        getTranslated(context, 'paste_it_above')!,
                                        style: GoogleFonts.allerta(
                                          color: const Color(0xFFBC9A46),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  customListTile(number: getTranslated(context, '02'), description: getTranslated(context, 'Paste copy link in above field')),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.keyboard_double_arrow_right_rounded,
                                        size: 16,
                                        color: Color(0xFFBC9A46),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        getTranslated(context, 'download_is_ready')!,
                                        style: GoogleFonts.allerta(
                                          color: const Color(0xFFBC9A46),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  customListTile(number: getTranslated(context, '03'), description: getTranslated(context, 'Click on download to enjoy your watermark free internet video')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Colors.grey, width: 1.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: TextField(
                              cursorColor: theme.myAppMainColor,
                              controller: downloadUrlController,
                              obscureText: false,
                              onSubmitted: (input) async {
                                if (iUtils.isConnected) {
                                  getDownloadLinkData();
                                } else {
                                  showToast(context, "No Internet Connection");
                                }
                              },
                              style: GoogleFonts.allerta(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                letterSpacing: 0.5,
                              ),
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                suffixIcon: const Icon(
                                  Icons.info_outline_rounded,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                                prefixIcon: GestureDetector(
                                  onTap: () async {
                                    ClipboardData? data = await Clipboard.getData('text/plain');
                                    downloadUrlController!.text = data!.text.toString();
                                    FocusScope.of(context).requestFocus(FocusNode());
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    margin: const EdgeInsets.only(
                                      right: 8.0,
                                    ),
                                    child: const Icon(
                                      Icons.paste,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [theme.myAppMainColor, theme.myAppMainColor],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [0.0, 0.8],
                                      ),
                                      color: theme.myAppMainColor,
                                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(16), right: Radius.circular(16)),
                                    ),
                                  ),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                hintText: 'Paste Video URL Here',
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    InkWell(
                      onTap: () async {
                        await iUtils.checkingInternet();
                        if (iUtils.isConnected) {
                          getDownloadLinkData();
                        } else {
                          showToast(context, "No Internet Connection");
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_download_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Text(
                              "Download",
                              style: GoogleFonts.allerta(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [theme.myAppMainColor, theme.myAppMainColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.8],
                          ),
                          color: theme.myAppMainColor,
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(16), right: Radius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            itemBuilder: (context, position) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(MyIconsList.moreFeaturesList[position]['icon'], height: 32, width: 32),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              MyIconsList.moreFeaturesList[position]['title'],
                                              style: GoogleFonts.allerta(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11.0,
                                                letterSpacing: 0.1,
                                              ),
                                            ),
                                            Text(
                                              MyIconsList.moreFeaturesList[position]['subtitle'],
                                              style: GoogleFonts.allerta(
                                                color: Colors.grey,
                                                fontSize: 10.0,
                                                letterSpacing: 0.1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            shrinkWrap: true,
                            itemCount: MyIconsList.moreFeaturesList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 1.0,
                              childAspectRatio: 3.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            itemBuilder: (context, position) {
                              if (MyIconsList.supportedWebsiteIcons[position]['name'] != "Youtube") {
                                return Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MyIconsList.supportedWebsiteIcons[position]['background'],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Image(image: AssetImage(MyIconsList.supportedWebsiteIcons[position]['icon'])),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        MyIconsList.supportedWebsiteIcons[position]['name'],
                                        style: GoogleFonts.allerta(
                                          color: Colors.black,
                                          fontSize: 10.0,
                                          letterSpacing: 0.1,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                if (iUtils.isYTDAvailable) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: MyIconsList.supportedWebsiteIcons[position]['background'],
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Image(image: AssetImage(MyIconsList.supportedWebsiteIcons[position]['icon'])),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          MyIconsList.supportedWebsiteIcons[position]['name'],
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }
                            },
                            shrinkWrap: true,
                            itemCount: MyIconsList.supportedWebsiteIcons.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
              handleBottomSheet(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet(ScrollController controller, NewApiParser apiParser) {
    String duration;
    try {
      duration = Duration(seconds: apiParser.videos![0].duration).toString().split(".")[0];
    } catch (e) {
      duration = " NAN";
    }

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      controller: controller,
      child: Container(
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5, offset: Offset(0.7, 0.7))], borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        height: MediaQuery.of(context).size.height * 0.88,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3, spreadRadius: 2)]),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    showBottomSheetForDownload = false;
                  });
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
              ),
            ),
            ListTile(
              leading: SizedBox(
                width: 100,
                child: Image.network(
                  apiParser.videos![0].thumbnail,
                  fit: BoxFit.fill,
                ),
              ),
              title: RichText(
                text: TextSpan(children: [
                  TextSpan(text: getTranslated(context, 'title'), style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
                  TextSpan(text: apiParser.videos![0].title, style: const TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold)),
                ]),
              ),
              subtitle: RichText(
                text: TextSpan(children: [
                  TextSpan(text: getTranslated(context, 'duration'), style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
                  TextSpan(text: duration, style: const TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            ListTile(
              leading: Text(
                getTranslated(context, 'select_quality')!,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              title: Text(
                getTranslated(context, 'source')!,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
              ),
              trailing: Text(apiParser.videos![0].extractorKey.toString(), style: const TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            videoInfoPanel(),
            videoDownloadableList(),
          ],
        ),
      ),
    );
  }

  void getDownloadLinkData() async {
    try {
      if (downloadUrlController!.text.isNotEmpty && downloadUrlController!.text.contains("http")) {
        if (downloadUrlController!.text.contains("instagram")) {
          InstagramLinkDownloader myInsta = InstagramLinkDownloader();
          try {
            await pr!.show();
            await myInsta.downloadVideo(downloadUrlController!.text, context);
            await pr!.hide();
          } catch (e) {
            showToast(context, getTranslated(context, "download_error_url"));
            await pr!.hide();
          }
        } else if (downloadUrlController!.text.contains("twitter")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await TwitterVideoDownloader.downloadVideo(downloadUrlController!.text);
          webServiceDownloader(downloadUrl, "twitter");
        }

        ///todo implement Facebook
        else if (downloadUrlController!.text.contains("facebook") || downloadUrlController!.text.contains("fb.watch")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          try {
            String downloadUrl = await FacebookVideoDownloader.downloadVideo(downloadUrlController!.text);
            webServiceDownloader(downloadUrl, "facebook");
          } catch (e) {
            showToast(context, getTranslated(context, "download_error_url"));
            await pr!.hide();
          }
        } else if (downloadUrlController!.text.contains("roposo")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          try {
            String downloadUrl = await RoposoVideoDownloader.downloadVideo(downloadUrlController!.text);
            webServiceDownloader(downloadUrl, "roposo");
          } catch (e) {
            showToast(context, getTranslated(context, "download_error_url"));
            await pr!.hide();
          }
        } else if (downloadUrlController!.text.contains("chingari")) {
          if (Platform.isAndroid || Platform.isIOS) {
            await pr!.show();
          }
          try {
            String downloadUrl = await ChingariVideoDownloader.downloadVideo(downloadUrlController!.text);
            webServiceDownloader(downloadUrl, "chingari");
          } catch (e) {
            showToast(context, getTranslated(context, "download_error_url"));
            await pr!.hide();
          }
        } else if (downloadUrlController!.text.contains("moj")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          try {
            String downloadUrl = await MojVideoDownloader.downloadVideo(downloadUrlController!.text);
            webServiceDownloader(downloadUrl, "moj");
          } catch (e) {
            showToast(context, getTranslated(context, "download_error_url"));
            await pr!.hide();
          }
        } else if (downloadUrlController!.text.contains("sharechat")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await ShareChatVideoDownloader.downloadVideo(downloadUrlController!.text);
          webServiceDownloader(downloadUrl, "shareChat");
        } else if (downloadUrlController!.text.contains("mitron.tv")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await MitronVideoDownloader.downloadVideo(downloadUrlController!.text);
          webServiceDownloader(downloadUrl, "mitron.tv");
        } else if (downloadUrlController!.text.contains("likee")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await LikeeVideoDownloader.downloadVideo(downloadUrlController!.text, context);
          webServiceDownloader(downloadUrl, "likee");
        } else if (downloadUrlController!.text.contains("takatak")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await MxTakaTakVideoDownloader.downloadVideo(downloadUrlController!.text);
          webServiceDownloader(downloadUrl, "takatak");
        } else if (downloadUrlController!.text.contains("josh")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await JoshVideoDownloader.downloadVideo(downloadUrlController!.text);
          webServiceDownloader(downloadUrl, "josh");
        } else if (downloadUrlController!.text.contains("linkedin")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await LinkedInVideoDownloader.downloadVideo(downloadUrlController!.text);
          webServiceDownloader(downloadUrl, "linkedin");
        } else if (downloadUrlController!.text.contains("imdb")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await IMDBVideoDownloader.downloadVideo(downloadUrlController!.text, "imdb");
          webServiceDownloader(downloadUrl, "linkedin");
        } else if (downloadUrlController!.text.contains("espn")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await ESPNVideoDownloader.downloadVideo(downloadUrlController!.text, "imdb");
          webServiceDownloader(downloadUrl, "espm");
        } else if (downloadUrlController!.text.contains("tiktok")) {
          if (Platform.isAndroid || Platform.isIOS) {
            //print("workin 1");
            await pr!.show();
          }
          String downloadUrl = await TiktokVideoDownloader.downloadVideo(downloadUrlController!.text);
          webServiceDownloader(downloadUrl, "tiktok");
        } else {
          if (downloadUrlController!.text.contains("youtu.be") || downloadUrlController!.text.contains("youtube")) {
            if (iUtils.isYTDAvailable) {
              try {
                if (Platform.isAndroid || Platform.isIOS) {
                  await pr!.show();
                }
                apiParser = await DlPhpApi.downloadVideo(downloadUrlController!.text, "source");
                //print(apiParser.url);
                await pr!.hide();
                setState(() {
                  showBottomSheetForDownload = true;
                });
              } catch (e) {
                showToast(context, getTranslated(context, "download_error_url"));
                await pr!.hide();
              }
            } else {
              showToast(context, getTranslated(context, "download_error_url"));
              await pr!.hide();
            }
          } else {
            try {
              if (Platform.isAndroid || Platform.isIOS) {
                await pr!.show();
              }
              apiParser = await DlPhpApi.downloadVideo(downloadUrlController!.text, "source");
              //print(apiParser.url);
              await pr!.hide();
              setState(() {
                showBottomSheetForDownload = true;
              });
            } catch (e) {
              //print(e);
              showToast(context, getTranslated(context, "download_error_url"));
              await pr!.hide();
            }
          }
        }
      } else {
        showToast(context, getTranslated(context, "download_error_url"));
        await pr!.hide();
      }
    } catch (e) {
      showToast(context, getTranslated(context, "download_error_url"));
      await pr!.hide();
    }
  }

  Future downloadFile12(String url, String savePath) async {
    String errorMessage = "Can not fetch data for the link provided. Try again with another link.";
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        //print("workin 1");
        await pr!.show();
      }
      try {
        Response response = await Dio().download(
          url,
          savePath,
        );
        if (response.statusCode == 200) {
          await showToast(context, getTranslated(context, "download_complete")! + savePath + "\"");
          await pr!.hide();
        }
      } on DioError catch (ex) {
        if (ex.type == DioErrorType.other) {
          pr!.hide();
          errorMessage = "Connection Time Out\nPlease check your internet connection";
        }
        throw Exception(ex.message);
      }
    } catch (e) {
      try {
        final downloaderUtils = DownloaderUtils(
          progressCallback: (current, total) {
            final progress = (current / total) * 100;
            if (progress % 10 == 0) {
              //print('Downloading: $progress');
            }
          },
          file: File(savePath),
          progress: ProgressImplementation(),
          onDone: () async {
            await showToast(context, getTranslated(context, "download_complete")! + savePath + "\"");
            await pr!.hide();
          },
          deleteOnCancel: true,
        );
        await Flowder.download(url, downloaderUtils);
      } catch (e2) {
        await pr!.hide();
        showToast(context, errorMessage);
      }
    }
  }

  webServiceDownloader(String url, String source) async {
    if (url != null) {
      String tempDir = await iUtils.getMyDownloadDirectory();
      String halfpath = tempDir + iUtils.nameModifier;
      // File file = File(halfpath);
      if (!Directory(halfpath).existsSync()) {
        Directory(halfpath).create();
      }
      String fullPath = halfpath + "/" + iUtils.nameModifier + "_${source}_" + DateTime.now().millisecondsSinceEpoch.toString() + ".mp4";

      await downloadFile12(url, fullPath);
      //print("^^^");
    } else {
      await pr!.hide();
      showToast(context, getTranslated(context, "download_error_url"));
    }
  }

  Future downloadFile1(String url, String savePath) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        //print("workin 1");
        await pr!.show();
      }
      Response response = await Dio().download(url, savePath).whenComplete(() => () async {
            await pr!.hide();
            showToast(context, getTranslated(context, "download_complete")! + savePath + "\"");
            await pr!.hide();
          });
      await pr!.hide();
      //print("Download Completed");
    } catch (e) {
      await pr!.hide();
      if (Platform.isAndroid || Platform.isIOS) {
        //print("workin 1");
        await pr!.show();
      }
      Response response = await Dio().download(url, savePath).whenComplete(() => () async {
            await pr!.hide();
            showToast(context, getTranslated(context, "download_complete")! + savePath + "\"");

            Navigator.of(context).pop(alert);
          });
    }
  }

  showToast(BuildContext? context, var test) {
    final scaffold = ScaffoldMessenger.of(context!);
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

  void downloadSelectedFile(int i) async {
    var imageurl = apiParser!.videos![0].formats![i].url;
    var ext = apiParser!.videos![0].ext;
    if (Platform.isAndroid || Platform.isIOS) {
      //print("workin 2");
      String tempDir = await iUtils.getMyDownloadDirectory();

      String halfpath = tempDir + iUtils.nameModifier;

      // File file = File(halfpath);
      if (!Directory(halfpath).existsSync()) {
        Directory(halfpath).create();
      }
      String fullPath = halfpath + "/" + iUtils.nameModifier + "_" + DateTime.now().millisecondsSinceEpoch.toString() + ".$ext";
      //print('full path ${fullPath}');

      downloadFile12(imageurl, fullPath);
      // pr!.hide();
    } else {
      //    html.window.open(imageurl, 'Download_Video');
      showToast(context, getTranslated(context, "download_error_platform"));
      // html.AnchorElement anchorElement =
      //     new html.AnchorElement(href: imageurl);
      // anchorElement.download = imageurl;
      // anchorElement.click();
    }
  }

  Widget videoInfoPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(getTranslated(context, "resolution")!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(getTranslated(context, "filesize")!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(getTranslated(context, "download")!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget videoDownloadableList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          String fileSize = (apiParser!.videos![0].formats![i].filesize != null) ? filesize(apiParser!.videos![0].formats![i].filesize) : "NAN";
          //print("apiParser.videos[0].url");
          //print(apiParser.videos[0].url);
          String videoProtoco = apiParser!.videos![0].formats![i].protocol.toString();
          //print(videoProtoco);
          return (videoProtoco == 'Protocol.HTTPS' || videoProtoco == 'Protocol.HTTP' || videoProtoco == 'https' || videoProtoco == 'http')
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        apiParser!.videos![0].formats![i].format,
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        fileSize,
                        textAlign: TextAlign.center,
                      )),
                      RaisedButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        color: theme.myAppMainColor,
                        onPressed: () async {
                          downloadSelectedFile(i);
                        },
                        child: Text(
                          getTranslated(context, 'download_text')!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              : Container();
        },
        itemCount: apiParser!.videos![0].formats!.length,
      ),
    );
  }

  Widget handleBottomSheet() {
    return showBottomSheetForDownload
        ? SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: DraggableScrollableSheet(
              initialChildSize: 500 / MediaQuery.of(context).size.height,
              minChildSize: 98 / MediaQuery.of(context).size.height,
              maxChildSize: 1,
              builder: (BuildContext context, controller) {
                return _bottomSheet(controller, apiParser!);
              },
            ),
          )
        : Container();
  }

  customListTile({String? number, String? description}) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Text(
            number!,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 13,
          ),
          Text(
            description!,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
