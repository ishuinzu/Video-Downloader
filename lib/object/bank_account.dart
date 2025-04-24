import 'package:video_downloader/database/database_helper.dart';

class BankAccount {
  late int id;
  late String bankname;
  late String bankaddress;
  late String type;
  late String fullname;
  late String phone;
  late String email;
  late String homeaddress;
  late String iban;

  BankAccount();

  BankAccount.fromMap(Map<dynamic, dynamic> map) {
    id = map[idColumn];
    bankname = map[banknameBankAccount];
    bankaddress = map[bankaddressBankAccount];
    type = map[typeBankAccount];
    fullname = map[fullnameBankAccount];
    phone = map[phoneBankAccount];
    email = map[emailBankAccount];
    homeaddress = map[homeaddressBankAccount];
    iban = map[ibanBankAccount];
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      banknameBankAccount: bankname,
      bankaddressBankAccount: bankaddress,
      typeBankAccount: type,
      fullnameBankAccount: fullname,
      phoneBankAccount: phone,
      emailBankAccount: email,
      homeaddressBankAccount: homeaddress,
      ibanBankAccount: iban,
    };

    if (id != 9999999999) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Data(id: $id, bankname: $bankname, bankaddress: $bankaddress, type: $type, fullname: $fullname, , phone: $phone, email: $email, homeaddress: $homeaddress, iban: $iban)";
  }
}
