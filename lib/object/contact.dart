import 'package:video_downloader/database/database_helper.dart';

class Contact {
  late int id;
  late String name;
  late String phone;
  late String address;
  late String type;

  Contact();

  Contact.fromMap(Map<dynamic, dynamic> map) {
    id = map[idColumn];
    name = map[nameContactColumn];
    phone = map[phoneContactColumn];
    address = map[addressContactColumn];
    type = map[typeContactColumn];
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      nameContactColumn: name,
      phoneContactColumn: phone,
      addressContactColumn: address,
      typeContactColumn: type,
    };

    if (id != 9999999999) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Data(id: $id, name: $name, phone: $phone, address: $address, type: $type)";
  }
}
