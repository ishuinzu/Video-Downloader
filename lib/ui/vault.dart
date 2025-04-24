import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:video_downloader/ui/check_pattern_lock.dart';
import 'package:video_downloader/ui/pattern_lock.dart';
import 'package:video_downloader/ui/settingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VaultScreen extends StatefulWidget {
  const VaultScreen({Key? key}) : super(key: key);

  @override
  _VaultScreenState createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  late SharedPreferences prefs;
  late String activity;

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.myAppMainColor,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
          },
          child: const Icon(
            AntDesign.setting,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Vault",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: theme.myAppMainColor.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    itemBuild("App Lock", Icons.lock_outline),
                    itemBuild("Hide Images/Videos", FlutterIcons.youtube_fea),
                    itemBuild("Secret Contacts", FlutterIcons.contacts_ant),
                    itemBuild("Social Profiles", FlutterIcons.social_facebook_sli),
                    itemBuild("Bank Accounts", FlutterIcons.bank_ant),
                    itemBuild("Bank Cards", FlutterIcons.card_outline_mco),
                    itemBuild("Private Texts", FlutterIcons.pencil_lock_outline_mco),
                    itemBuild("Private Browser", FlutterIcons.browser_ent),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  itemBuild(String title, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          activity = title;
        });
        lockScreenAction();
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListTile(
          leading: SizedBox(
            width: 25,
            height: 25,
            child: Icon(
              icon,
              color: theme.myAppMainColor,
            ),
          ),
          trailing: SizedBox(
            width: 25,
            height: 25,
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  activity = title;
                });
                lockScreenAction();
              },
              textColor: Colors.white,
              child: Icon(
                FlutterIcons.rightcircle_ant,
                color: theme.myAppMainColor,
                size: 20,
              ),
              padding: const EdgeInsets.all(4),
              shape: const CircleBorder(),
            ),
          ),
          title: Text(title),
        ),
      ),
    );
  }

  lockScreenAction() {
    if (prefs.containsKey("patterncodes")) {
      // Redirect To Check Lock Screen
      Fluttertoast.showToast(msg: "CHECKING", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 12.0);
      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckPatternLockScreen(activity: activity, purpose: "Vault Apps")));
    } else {
      // Redirect To Set Lock Screen
      Fluttertoast.showToast(msg: "SETTING", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 12.0);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const PatternLockScreen()));
    }
  }
}
