import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/ui/dashboard.dart';
import 'package:video_downloader/utils/utils.dart';

import '../main.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class StatussaverHome extends StatefulWidget {
  @override
  _StatussaverHomeState createState() => _StatussaverHomeState();
}

class _StatussaverHomeState extends State<StatussaverHome> {
  var sdkInt = 30;

  getDirectory() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      sdkInt = androidInfo.version.sdkInt!;
    } else {
      sdkInt = 30;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            // Added
            length: 2,
            // Added
            initialIndex: 0,
            //Added
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text('Status Saver'),
                backgroundColor: theme.myAppMainColor,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share('check out whatsapp status downloader ',
                            subject: 'Look what I made!');
                      }),
                  IconButton(
                      icon: Icon(Icons.help_outline),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  height: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                     //   Html(data: html),
                                        Expanded(
                                          child: new Align(
                                            alignment: Alignment.bottomRight,
                                            child: FlatButton(
                                              child: Text(
                                                'OK!',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      })
                ],
                bottom: TabBar(tabs: [
                  Container(
                    height: 35.0,
                    child: Center(
                      child: Text(
                        'IMAGES',
                      ),
                    ),
                  ),
                  Container(
                    height: 35.0,
                    child: Center(
                      child: Text(
                        'VIDEOS',
                      ),
                    ),
                  ),
                ]),
              ),
              body: Dashboard(),
              backgroundColor: Colors.white,
            )));
  }
}
