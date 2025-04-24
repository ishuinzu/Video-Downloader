import 'package:video_downloader/database/database_helper.dart';

class BankCard {
  late int id;
  late String name;
  late String holder;
  late String number;
  late String expirydate;
  late String cvc;
  late String pin;

  BankCard();

  BankCard.fromMap(Map<dynamic, dynamic> map) {
    id = map[idColumn];
    name = map[nameBankCard];
    holder = map[holderBankCard];
    number = map[numberBankCard];
    expirydate = map[expirydateBankCard];
    cvc = map[cvcBankCard];
    pin = map[pinBankCard];
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      nameBankCard: name,
      numberBankCard: number,
      holderBankCard: holder,
      expirydateBankCard: expirydate,
      cvcBankCard: cvc,
      pinBankCard: pin,
    };

    if (id != 9999999999) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Data(id: $id, name: $name, holder: $holder, number: $number, expirydate: $expirydate, cvc: $cvc, , pin: $pin)";
  }
}
