import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/main.dart';
import 'package:video_downloader/res.dart';
import 'package:video_downloader/ui/gallery.dart';
import 'package:video_downloader/ui/settingScreen.dart';
import 'package:video_downloader/ui/status_saver_main.dart';
import 'package:video_downloader/ui/supported_wesites.dart';
import 'package:video_downloader/utils/utils.dart';

class MenuWidget extends StatelessWidget {
  final Function(String)? onItemClick;

   MenuWidget({this.onItemClick});

  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: theme.myAppMainColor),
          accountName: Text(
            'all_video_downloader_flutter',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          accountEmail: Text('Version: ' + iUtils.version,
              style: TextStyle(color: Colors.white)),
          currentAccountPicture: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(Res.logo),
              ),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: iUtils.myAppNavigationIconColor),
                child: Icon(Icons.home)),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: iUtils.myAppNavigationIconColor),
                child: Icon(Icons.add_photo_alternate)),
            title: Text(getTranslated(context, 'mydrawar_gal')!),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GalleryVideos()));
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: iUtils.myAppNavigationIconColor),
                child: Image.asset(
                  Res.statuspic,
                  width: 25,
                  height: 25,
                  color: iUtils.myAppNavigationIconColor,
                )),
            title: Text(getTranslated(context, 'mydrawar_status')!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatussaverHome()),
              );
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: iUtils.myAppNavigationIconColor),
                child: Icon(Icons.list_alt)),
            title: Text(getTranslated(context, 'download_supportedtext')!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Supported_websitespage()),
              );
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: iUtils.myAppNavigationIconColor),
                child: Icon(Icons.open_in_browser)),
            title: Text(getTranslated(context, 'live_version')!),
            onTap: () {
              _launchAboutURL();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => AboutScreen()),
              // );
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: iUtils.myAppNavigationIconColor),
                child: Icon(Icons.rate_review)),
            title: Text(getTranslated(context, 'mydrawar_rateus')!),
            onTap: () async {
              if (await inAppReview.isAvailable()) {
                inAppReview.requestReview();
              }
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: iUtils.myAppNavigationIconColor),
                child: Icon(Icons.share)),
            title: Text(getTranslated(context, 'mydrawar_sharewithfriend')!),
            onTap: () {
              Share.share(getTranslated(context, 'mydrawar_checkall')!,
                  subject: getTranslated(context, 'supportedpage_lookwhats'));
            },
          ),
        ),

        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: iUtils.myAppNavigationIconColor),
                child: Icon(Icons.settings)),
            title: Text(getTranslated(context, 'settings')!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
          ),
        ),
        // Card(
        //   child: ListTile(
        //     leading: IconTheme(
        //         data: new IconThemeData(color: iUtils.myAppNavigationIconColor),
        //         child: Icon(Icons.settings)),
        //     title: Text('Paypal'),
        //     onTap: () {
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(builder: (context) => PaypalWebview()),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  _launchURL() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String packageName = packageInfo.packageName;

    var url = 'https://play.google.com/store/apps/details?id=' + packageName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchAboutURL() async {
    const url = 'http://video.infusiblecoder.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget sliderItem(String title, IconData icons) => ListTile(
      title: Text(
        title,
        style:
            TextStyle(color: Colors.black, fontFamily: 'BalsamiqSans_Regular'),
      ),
      leading: Icon(
        icons,
        color: Colors.black,
      ),
      onTap: () {
        onItemClick!(title);
      });
}
