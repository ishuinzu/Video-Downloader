import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader/object/social_profile.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_downloader/res.dart';
import 'package:video_downloader/ui/new_social_profile.dart';
import 'package:video_downloader/ui/update_social_profile.dart';

class SocialProfileScreen extends StatefulWidget {
  const SocialProfileScreen({Key? key}) : super(key: key);

  @override
  _SocialProfileScreenState createState() => _SocialProfileScreenState();
}

class _SocialProfileScreenState extends State<SocialProfileScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<SocialProfile> social_profiles = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    getSocialProfiles();
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
          "Social Profiles",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newSocialProfileAction();
        },
        child: const Icon(Icons.add),
        backgroundColor: theme.myAppMainColor,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: theme.myAppMainColor.withOpacity(0.05),
            child: social_profiles.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: social_profiles.length,
                    itemBuilder: (context, index) {
                      return dataCard(context, index);
                    },
                  )
                : Center(
                    child: Text(
                      "No Social Profile Found",
                      style: TextStyle(
                        color: theme.myAppMainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  newSocialProfileAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewSocialProfileScreen()));
  }

  void getSocialProfiles() {
    databaseHelper.getSocialProfiles().then((list) {
      setState(() {
        for (var element in list) {
          social_profiles.add(element);
        }
      });
    });
  }

  Widget dataCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(context, index);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    getSocialIconPath(social_profiles[index].type),
                    height: 32,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Text(
                    social_profiles[index].username,
                    style: TextStyle(
                      color: theme.myAppMainColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Email : " + social_profiles[index].emailid,
                  style: TextStyle(
                    color: theme.myAppMainColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "Password : " + social_profiles[index].password,
                  style: TextStyle(
                    color: theme.myAppMainColor,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getSocialIconPath(String type) {
    if (type == "Dailymotion") {
      return Res.dailymotion;
    } else if (type == "Facebook") {
      return Res.facebook;
    } else if (type == "Instagram") {
      return Res.instegram;
    } else if (type == "Linkedin") {
      return Res.linkedin;
    } else if (type == "Reddit") {
      return Res.reddit;
    } else if (type == "Soundcloud") {
      return Res.soundcloud;
    } else if (type == "Twitter") {
      return Res.twitter;
    } else if (type == "Vimeo") {
      return Res.vimeo;
    } else {
      return Res.logo;
    }
  }

  showBottomSheet(BuildContext context, int index) {
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
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSocialProfileScreen(socialProfile: social_profiles[index])));
                        },
                        textColor: Colors.white,
                        child: Icon(
                          FlutterIcons.edit_fea,
                          color: theme.myAppMainColor,
                          size: 24,
                        ),
                        shape: const CircleBorder(),
                      ),
                      Text(
                        "Edit",
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
                          int? effectedRows = await databaseHelper.deleteSocialProfile(social_profiles[index].id);
                          if (effectedRows > 0) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Social Profile Deleted"),
                            ));
                            social_profiles.clear();
                            getSocialProfiles();
                          }
                        },
                        textColor: Colors.white,
                        child: Icon(
                          FlutterIcons.delete_fea,
                          color: theme.myAppMainColor,
                          size: 24,
                        ),
                        shape: const CircleBorder(),
                      ),
                      Text(
                        "Delete",
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
                          Navigator.pop(context);
                          await launch(social_profiles[index].profilelink);
                        },
                        textColor: Colors.white,
                        child: Icon(
                          FlutterIcons.open_in_browser_mdi,
                          color: theme.myAppMainColor,
                          size: 24,
                        ),
                        shape: const CircleBorder(),
                      ),
                      Text(
                        "Profile",
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
