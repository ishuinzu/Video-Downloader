import 'package:video_downloader/database/database_helper.dart';

class SocialProfile {
  late int id;
  late String type;
  late String username;
  late String emailid;
  late String password;
  late String profilelink;

  SocialProfile();

  SocialProfile.fromMap(Map<dynamic, dynamic> map) {
    id = map[idColumn];
    type = map[typeSocialProfileColumn];
    username = map[usernameSocialProfileColumn];
    emailid = map[emailidSocialProfileColumn];
    password = map[passwordSocialProfileColumn];
    profilelink = map[profilelinkSocialProfileColumn];
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      typeSocialProfileColumn: type,
      usernameSocialProfileColumn: username,
      emailidSocialProfileColumn: emailid,
      passwordSocialProfileColumn: password,
      profilelinkSocialProfileColumn: profilelink,
    };

    if (id != 9999999999) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Data(id: $id, name: $type, phone: $username, address: $emailid, type: $password, profilelink: $profilelink)";
  }
}
