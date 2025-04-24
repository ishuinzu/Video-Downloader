import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/res.dart';
import 'package:video_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class MyappBarswidget extends AppBar {
  MyappBarswidget(
      BuildContext context, GlobalKey<SliderDrawerState>?  _scaffoldKey, String text)
      : super(
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => _scaffoldKey!.currentState!.openSlider()),
          title: Text("Home", style: TextStyle(color: Colors.white)),
          backgroundColor: theme.myAppMainColor,
          actions: <Widget>[
            IconButton(
                icon: Image.asset(
                  Res.whatsapp,
                  height: 30,
                  width: 30,
                  color: Colors.white,
                ),
                onPressed: () async {
                  var whatsappUrl = "whatsapp://send?phone=+923402332136";
                  await canLaunch(whatsappUrl)
                      ? launch(whatsappUrl)
                      : print(getTranslated(context, 'openwhatsapp'));
                }),
            IconButton(
                icon: Icon(
                  Icons.help_outline,
                  color: Colors.white,
                ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Html(data: iUtils.html),
                                  Expanded(
                                    child: new Align(
                                      alignment: Alignment.bottomRight,
                                      child: FlatButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.green),
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
                }),
          ],
        );

}
