import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:video_downloader/object/locked_app.dart';
import 'package:video_downloader/ui/check_pattern_lock.dart';
import '../database/database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({Key? key}) : super(key: key);

  @override
  _AppLockScreenState createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  bool isAuthenticated = false;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<LockedApp> lockedApps = List.empty(growable: true);
  late String packageUnderConsideration;

  @override
  void initState() {
    super.initState();
    getLockedApps();
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
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          "App Lock",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 8.0,
              bottom: 0.0,
              right: 16.0,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: theme.myAppMainColor.withOpacity(0.05),
            child: FutureBuilder<List<AppInfo>>(
              future: InstalledApps.getInstalledApps(true, true),
              builder: (BuildContext buildContext, AsyncSnapshot<List<AppInfo>> snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              AppInfo app = snapshot.data![index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.memory(app.icon!),
                                  ),
                                  title: Text(
                                    app.name!,
                                    style: TextStyle(
                                      color: theme.myAppMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    app.getVersionInfo(),
                                    style: TextStyle(
                                      color: theme.myAppMainColor,
                                    ),
                                  ),
                                  onTap: () {
                                    showBottomSheet(context, app.packageName!);
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "Error Occurred While Getting Installed Apps",
                              style: TextStyle(
                                color: theme.myAppMainColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                    : Center(
                        child: Text(
                          "Getting Installed Apps",
                          style: TextStyle(
                            color: theme.myAppMainColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  void getLockedApps() {
    databaseHelper.getLockedApps().then((list) {
      setState(() {
        for (var element in list) {
          lockedApps.add(element);
        }
      });
    });
  }

  showBottomSheet(BuildContext context, String packageName) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          builder: (context) {
            return Container(
              height: 100,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          if (lockedApps.any((element) => element.packagename == packageName)) {
                            Fluttertoast.showToast(msg: "LOCKED", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 12.0);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CheckPatternLockScreen(activity: packageName, purpose: "Open Package")));
                          } else {
                            Navigator.pop(context);
                            InstalledApps.startApp(packageName);
                          }
                        },
                        textColor: Colors.white,
                        child: Icon(
                          FlutterIcons.open_in_new_mco,
                          color: theme.myAppMainColor,
                          size: 24,
                        ),
                        shape: const CircleBorder(),
                      ),
                      Text(
                        "Open",
                        style: TextStyle(
                          color: theme.myAppMainColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          if (lockedApps.any((element) => element.packagename == packageName)) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CheckPatternLockScreen(activity: packageName, purpose: "Unlock Package")));
                          } else {
                            // Lock App
                            LockedApp lockedApp = LockedApp();
                            lockedApp.packagename = packageName;
                            lockedApp.id = 9999999999; // NULL ID
                            await databaseHelper.insertLockedApp(lockedApp);
                            lockedApps.clear();
                            getLockedApps();
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: "LOCKED", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 12.0);
                          }
                        },
                        textColor: Colors.white,
                        child: Icon(
                          lockedApps.any((element) => element.packagename == packageName) ? FlutterIcons.unlock_fea : FlutterIcons.lock_fea,
                          color: theme.myAppMainColor,
                          size: 24,
                        ),
                        shape: const CircleBorder(),
                      ),
                      Text(
                        lockedApps.any((element) => element.packagename == packageName) ? "Remove Lock" : "Lock",
                        style: TextStyle(
                          color: theme.myAppMainColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          InstalledApps.openSettings(packageName);
                        },
                        textColor: Colors.white,
                        child: Icon(
                          FlutterIcons.settings_oct,
                          color: theme.myAppMainColor,
                          size: 24,
                        ),
                        shape: const CircleBorder(),
                      ),
                      Text(
                        "Setting",
                        style: TextStyle(
                          color: theme.myAppMainColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
