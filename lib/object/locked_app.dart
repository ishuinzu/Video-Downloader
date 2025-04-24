import 'package:video_downloader/database/database_helper.dart';

class LockedApp {
  late int id;
  late String packagename;

  LockedApp();

  LockedApp.fromMap(Map<dynamic, dynamic> map) {
    id = map[idColumn];
    packagename = map[packagenameLockedAppColumn];
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      packagenameLockedAppColumn: packagename,
    };

    if (id != 9999999999) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Data(id: $id, packagename: $packagename)";
  }
}
