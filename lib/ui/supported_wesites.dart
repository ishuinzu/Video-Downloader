import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/utils/my_icons_list.dart';
import 'package:video_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import '../main.dart';

final GlobalKey<ScaffoldState> _scaffoldKey_supp = GlobalKey<ScaffoldState>();

class Supported_websitespage extends StatefulWidget {
  @override
  _Supported_websitespageState createState() => _Supported_websitespageState();
}

GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

class _Supported_websitespageState extends State<Supported_websitespage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey_supp,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Image.asset("assets/images/supported_website_icon.png"),
          ),
          // centerTitle: true,
          title: Text(getTranslated(context, 'download_supportedtext')!, style: const TextStyle(color: Color(0xFF535660))),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/backImage.jpg'), fit: BoxFit.cover),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            color: theme.myAppMainColor.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    itemBuilder: (context, position) {
                      if (MyIconsList.supportedWebsiteIcons[position]['name'] != "Youtube") {
                        return Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
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
                        if (iUtils.isYTDAvailable) {
                          return Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
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
          ),
        ),
      ),
    );
  }
}
