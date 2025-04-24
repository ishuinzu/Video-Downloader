import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_downloader/ui/app_lock.dart';
import 'package:video_downloader/ui/bank_account.dart';
import 'package:video_downloader/ui/bank_card.dart';
import 'package:video_downloader/ui/hide_images_videos.dart';
import 'package:video_downloader/ui/private_browser.dart';
import 'package:video_downloader/ui/private_text.dart';
import 'package:video_downloader/ui/secret_contact.dart';
import 'package:video_downloader/ui/social_profile.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckPatternLockScreen extends StatefulWidget {
  const CheckPatternLockScreen({Key? key, required this.activity, required this.purpose}) : super(key: key);
  final String activity;
  final String purpose;

  @override
  _CheckPatternLockScreenState createState() => _CheckPatternLockScreenState();
}

class _CheckPatternLockScreenState extends State<CheckPatternLockScreen> {
  late List<int>? pattern;
  late SharedPreferences prefs;
  late String activityname;
  late String purpose;

  getPattern() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("patterncodes")) {
      List<String>? stringCodes = prefs.getStringList('patterncodes');
      pattern = stringCodes!.map((i) => int.parse(i)).toList();
    }
  }

  @override
  void initState() {
    super.initState();

    activityname = widget.activity;
    purpose = widget.purpose;
    getPattern();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        color: theme.myAppMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Flexible(
              child: Text(
                "Draw Pattern",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
            Flexible(
              child: PatternLock(
                selectedColor: Colors.white,
                notSelectedColor: Colors.grey,
                pointRadius: 12,
                onInputComplete: (List<int> input) async {
                  if (listEquals<int>(input, pattern)) {
                    if (prefs.containsKey("patterncodes")) {
                      // Redirect To Respective Activity
                      Navigator.pop(context);
                      if (activityname == "App Lock") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AppLockScreen()));
                      } else if (activityname == "Hide Images/Videos") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HideImagesVideosScreen()));
                      } else if (activityname == "Secret Contacts") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SecretContactScreen()));
                      } else if (activityname == "Social Profiles") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialProfileScreen()));
                      } else if (activityname == "Bank Accounts") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BankAccountScreen()));
                      } else if (activityname == "Bank Cards") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BankCardScreen()));
                      } else if (activityname == "Private Texts") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivateTextScreen()));
                      } else if (activityname == "Private Browser") {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivateBrowserScreen()));
                      } else if (purpose == "Open Package") {
                        InstalledApps.startApp(activityname);
                      } else if (purpose == "Unlock Package") {
                        DatabaseHelper databaseHelper = DatabaseHelper();
                        await databaseHelper.deleteLockedApp(activityname);
                        Fluttertoast.showToast(msg: "App Unlocked", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 12.0);
                      }
                    } else {
                      // Wrong Code
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
