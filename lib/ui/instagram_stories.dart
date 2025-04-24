import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/ui/instagram_login_webview_screen.dart';
import 'package:video_downloader/utils/instagram_story_model.dart';
import 'package:video_downloader/utils/reel_feeds_instagram.dart';
import 'package:video_downloader/utils/utils.dart';
import 'package:video_downloader/widgets/progress_dialog/src/progress_dialog.dart';

import '../main.dart';

class InstagramStories extends StatefulWidget {
  const InstagramStories({Key? key}) : super(key: key);

  @override
  _InstagramStoriesState createState() => _InstagramStoriesState();
}

class _InstagramStoriesState extends State<InstagramStories> {
  List<Tray>? myData;
  bool? isLoading = true;
  bool? storyTapped = false;
  bool? isLoggedIn = false;
  String? tappedUserId;

  var instaStoryReelFeedData;
  List<ReelFeedItem>? myData2 = [];
  ProgressDialog? pr;
  int? _progress = 0;
  AlertDialog? alert;
  var welcome;

  @override
  void initState() {
    // TODO: implement initState
    iUtils.checkingInternet();
    super.initState();
    getBoolValuesSF();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    pr!.style(
        message: getTranslated(context, "download_downloadingtext"),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircularProgressIndicator(),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: const TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
      body: iUtils.isConnected
          ? Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    isLoggedIn!
                        ? InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("isLoggedIn", false);
                              prefs.remove("ds_user_id");
                              prefs.remove("sessionid");
                              prefs.remove("cookies");
                              prefs.remove("mid");
                              prefs.remove("shbid");
                              prefs.remove("ig_did");
                              prefs.remove("shbts");
                              getBoolValuesSF();
                              storyTapped = false;
                              setState(() {});
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: theme.myAppMainColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                child: Text(
                                  "Logout from instagram",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    getInstagramStories(),
                    Container(child: storiesDetailBuilder(context)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: Text("No Internet Connection"),
              ),
            ),
    );
  }

  Widget getInstagramStories() {
    return !isLoggedIn!
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Instagram_webview()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      getTranslated(context, 'get_instagram_stories')!,
                      style: const TextStyle(color: Colors.white),
                    )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.myAppMainColor,
                ),
              ),
            ),
          )
        : Container(
            child: storiesBuilder(),
          );
  }

  storiesBuilder() {
    // for(int i = 0 ; i < myData.length ; i++)
    //   { // print("AS> ${welcome.tray[i].user.username}");
    //     print("asAs $i");
    //       print(myData[i].user.username);

    return myData != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: ListView.builder(
                itemCount: myData!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return buildList(context, index);
                },
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          )
        : iUtils.isConnected
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              )
            : const Text("No Internet Connection");

    // }
  }

  storiesDetailBuilder(BuildContext context) {
    try {
      if (iUtils.isConnected) {
        return storyTapped!
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  // color: Colors.red,
                  child: !isLoading! && myData2!.isNotEmpty
                      ? GridView.builder(
                          itemCount: myData2!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return build2List(context, index);
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 11.0,
                          ),
                        )
                      : myData2!.isEmpty && !isLoading!
                          ? Container(
                              child: const Center(child: Text("No Story Found")),
                            )
                          : const SizedBox(
                              width: 50,
                              height: 50,
                              child:
                                  Center(child: CircularProgressIndicator())),
                ),
              )
            : Container();
      } else {
        return storyTapped!
            ? Container(
                child: const Center(
                  child: Text("No Internet Connection"),
                ),
              )
            : Container();
      }
    } catch (e) {
      return const Text("Something Went Wong");
    }
  }

  buildList(BuildContext context, int index) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                isLoading = true;
                storyTapped = true;
                iUtils.checkingInternet();
                setState(() {});
                userOnTap(index);
              },
              child: Container(
                height: 130,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: theme.myAppMainColor,
                        child: CircleAvatar(
                          radius: 26.5,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              NetworkImage(myData![index].user!.profilePicUrl!),
                        ),
                      ),
                    ),
                    Text(
                      myData![index].user!.fullName!,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      myData![index].user!.username!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  build2List(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        storyOnTap(index, context);
      },
      child: Container(
        height: 130,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
                myData2![index].imageVersions2!.candidates![1].url!),
            fit: BoxFit.cover,
          ),

          // color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            myData2![index].mediaType == 2
                ? Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: theme.myAppMainColor,
                          ),
                          margin: const EdgeInsets.all(5),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 40,
                          )),
                    ],
                  )
                : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Download ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.file_download,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: theme.myAppMainColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  storyOnTap(int index, BuildContext context) async {
    print('i am called on tap');
    String tempDir = await iUtils.getMyDownloadDirectory();

    String halfpath = tempDir +  iUtils.nameModifier;

    // File file = File(halfpath);
    if (!Directory(halfpath).existsSync()) {
      Directory(halfpath).create();
    }
    String fullPath = halfpath +
        "/" +
        iUtils.nameModifier +
        "_" +
        DateTime.now().millisecondsSinceEpoch.toString();
    print('full path $fullPath');

    try {
      downloadfile1(
          myData2![index].videoVersions![0].url!, "$fullPath.mp4", context);
    } catch (e) {
      downloadfile1(myData2![index].imageVersions2!.candidates![0].url!,
          "$fullPath.jpg", context);
    }
  }

  userOnTap(int index) async {
    tappedUserId = (myData![index].user!.pk).toString();
    print(tappedUserId);
    httpCallerFunction();
  }

  Future downloadfile1(
      String url, String savePath, BuildContext context) async {
    print("resdatais3333 " + url.toString());
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await pr!.show();
      }
      await Dio().download(url, savePath);
      await pr!.hide();
      iUtils.showToast(context,
          getTranslated(context, "download_complete")! + savePath + "\"");
      print("Download Completed Try");
    } catch (e) {
      await pr!.hide();
      if (Platform.isAndroid || Platform.isIOS) {
        print("workin 1");
        await pr!.show();
      }
      await Dio().download(url, savePath);
      pr!.hide();
      iUtils.showToast(context,
          getTranslated(context, "download_complete")! + savePath + "\"");
      print("Download Completed catch");
    }
  }

  showToast(BuildContext context, var test) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(test),
        ),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
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

  httpCallerFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    var headers = {
      'Cookie':
          'ds_user_id=$userid; sessionid=$sessionid; ig_did=5E5CB448-4ACD-4E4A-9F34-C6E0ADD7153C; ig_nrcb=1; mid=YPKQVAAEAAFS8eba4lHDO7g1pskV; csrftoken=bX0EGcho96zPWweGgtpLbqATFkQn6Wgs; csrftoken=bX0EGcho96zPWweGgtpLbqATFkQn6Wgs; ds_user_id=24740642071; shbid="3179\\05424740642071\\0541658996682:01f70b561afd722ddb1f2549e61de839ebf908030481bf7c888b7825a5cadd7c9b13242f"; shbts="1627460682\\05424740642071\\0541658996682:01f79790bd926f4f789030ec950a6164b8a4ef3efa83ca366ab9c3091bac4a88f9f499fb"; rur="NAO\\05424740642071\\0541658996682:01f74dd301f5210ba70f87ca25ef77b0c52e29cf60ce59087e1c502624c4d9639a585017"',
      'User-Agent':
          'Instagram 9.5.2 (iPhone7,2; iPhone OS 9_3_3; en_US; en-US; scale=2.00; 750x1334) AppleWebKit/420+'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://i.instagram.com/api/v1/users/$tappedUserId/full_detail_info/'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    var res = await response.stream.bytesToString();

    // try {
    instaStoryReelFeedData = instaStoryReelFeedDataFromJson(res);

    myData2 = null;
    myData2 = instaStoryReelFeedData.reelFeed.items;
    isLoading = false;
    setState(() {});
    // } catch (e) {
    //   print(">>>> No Story Found "+e.toString());
    //   isLoading = false;
    //   setState(() {});
    // }
  }

  String? userid = "";
  String? sessionid = "";

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    userid = prefs.getString("ds_user_id");
    sessionid = prefs.getString("sessionid");
    String? cookies = prefs.getString("cookies");
    String? mid = prefs.getString("mid");
    String? shbid = prefs.getString("shbid");
    String? ig_did = prefs.getString("ig_did");
    String? shbts = prefs.getString("shbts");
    print("cookies $cookies");
    if (isLoggedIn!) {
      Dio dio = Dio();
      dio.options.headers['Cookie'] =
          'ds_user_id=$userid; sessionid=$sessionid';
      dio.options.headers['User-Agent'] =
          'Instagram 9.5.2 (iPhone7,2; iPhone OS 9_3_3; en_US; en-US; scale=2.00; 750x1334) AppleWebKit/420+';

      print("asasas ${dio.options.headers}");
      Response response =
          await dio.get("https://i.instagram.com/api/v1/feed/reels_tray/");
      print(response);
      welcome = welcomeFromJson(response.toString());
      setState(() {});
      // ds_user_id=24740642071; sessionid=24740642071%3A9YVp3bILOUA3ij%3A0
      myData = welcome.tray;
      print(myData![1].user!.username);
      print(":printing tray");
      print(welcome.tray[2].user.fullName);
      for (var item in welcome.tray) {
        print(item.user);
      }
    }
    print("asd");
    print(isLoggedIn);
    setState(() {});
  }
}
