import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:video_downloader/object/bank_card.dart';
import 'package:video_downloader/object/contact.dart';
import 'package:video_downloader/object/bank_account.dart';
import 'package:video_downloader/object/locked_app.dart';
import 'package:video_downloader/object/private_text.dart';
import 'package:video_downloader/object/social_profile.dart';

const String tableContacts = "Contacts";
const String idColumn = "_id";
const String nameContactColumn = "_name";
const String phoneContactColumn = "_phone";
const String addressContactColumn = "_address";
const String typeContactColumn = "_type";

const String tableSocialProfiles = "SocialProfiles";
const String typeSocialProfileColumn = "_type";
const String usernameSocialProfileColumn = "_username";
const String emailidSocialProfileColumn = "_emailid";
const String passwordSocialProfileColumn = "_password";
const String profilelinkSocialProfileColumn = "_profilelink";

const String tablePrivateTexts = "PrivateTexts";
const String subjectPrivateTextColumn = "_subject";
const String descriptionPrivateTextColumn = "_description";
const String categoryPrivateTextColumn = "_category";

const String tableBankAccounts = "BankAccounts";
const String banknameBankAccount = "_bankname";
const String bankaddressBankAccount = "_bankaddress";
const String typeBankAccount = "_type";
const String fullnameBankAccount = "_fullname";
const String phoneBankAccount = "_phone";
const String emailBankAccount = "_email";
const String homeaddressBankAccount = "_homeaddress";
const String ibanBankAccount = "_iban";

const String tableBankCards = "BankCards";
const String nameBankCard = "_name";
const String holderBankCard = "_holder";
const String numberBankCard = "_number";
const String expirydateBankCard = "_expirydate";
const String cvcBankCard = "_cvc";
const String pinBankCard = "_pin";

const String tableLockedApps = "LockedApps";
const String packagenameLockedAppColumn = "_packagename";

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  Future<Database> get db async {
    return await initDB();
  }

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "appdata.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      db.execute("CREATE TABLE $tableLockedApps("
          "$idColumn INTEGER PRIMARY KEY, "
          "$packagenameLockedAppColumn TEXT)");
      db.execute("CREATE TABLE $tableContacts("
          "$idColumn INTEGER PRIMARY KEY, "
          "$nameContactColumn TEXT, "
          "$phoneContactColumn TEXT, "
          "$addressContactColumn TEXT, "
          "$typeContactColumn TEXT)");
      db.execute("CREATE TABLE $tableSocialProfiles("
          "$idColumn INTEGER PRIMARY KEY, "
          "$typeSocialProfileColumn TEXT, "
          "$usernameSocialProfileColumn TEXT, "
          "$emailidSocialProfileColumn TEXT, "
          "$passwordSocialProfileColumn TEXT, "
          "$profilelinkSocialProfileColumn TEXT)");
      db.execute("CREATE TABLE $tableBankAccounts("
          "$idColumn INTEGER PRIMARY KEY, "
          "$banknameBankAccount TEXT, "
          "$bankaddressBankAccount TEXT, "
          "$typeBankAccount TEXT, "
          "$fullnameBankAccount TEXT, "
          "$phoneBankAccount TEXT, "
          "$emailBankAccount TEXT, "
          "$homeaddressBankAccount TEXT, "
          "$ibanBankAccount TEXT)");
      db.execute("CREATE TABLE $tableBankCards("
          "$idColumn INTEGER PRIMARY KEY, "
          "$nameBankCard TEXT, "
          "$holderBankCard TEXT, "
          "$numberBankCard TEXT, "
          "$expirydateBankCard TEXT, "
          "$cvcBankCard TEXT, "
          "$pinBankCard TEXT)");
      db.execute("CREATE TABLE $tablePrivateTexts("
          "$idColumn INTEGER PRIMARY KEY, "
          "$subjectPrivateTextColumn TEXT, "
          "$descriptionPrivateTextColumn TEXT, "
          "$categoryPrivateTextColumn)");
    });
  }

  Future<LockedApp> insertLockedApp(LockedApp lockedApp) async {
    Database dbAppData = await db;
    lockedApp.id = await dbAppData.insert(tableLockedApps, lockedApp.toMap());

    return lockedApp;
  }

  Future<Contact> insertContact(Contact contact) async {
    Database dbAppData = await db;
    contact.id = await dbAppData.insert(tableContacts, contact.toMap());

    return contact;
  }

  Future<SocialProfile> insertSocialProfile(SocialProfile socialProfile) async {
    Database dbAppData = await db;
    socialProfile.id = await dbAppData.insert(tableSocialProfiles, socialProfile.toMap());

    return socialProfile;
  }

  Future<BankAccount> insertBankAccount(BankAccount bankAccount) async {
    Database dbAppData = await db;
    bankAccount.id = await dbAppData.insert(tableBankAccounts, bankAccount.toMap());

    return bankAccount;
  }

  Future<BankCard> insertBankCard(BankCard bankCard) async {
    Database dbAppData = await db;
    bankCard.id = await dbAppData.insert(tableBankCards, bankCard.toMap());

    return bankCard;
  }

  Future<PrivateText> insertPrivateText(PrivateText privateText) async {
    Database dbAppData = await db;
    privateText.id = await dbAppData.insert(tablePrivateTexts, privateText.toMap());

    return privateText;
  }

  Future<LockedApp?> getLockedApp(int id) async {
    Database dbAppData = await db;
    List<Map> maps = await dbAppData.query(tableLockedApps, columns: [idColumn, packagenameLockedAppColumn], where: "idColumn = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      return LockedApp.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Contact?> getContact(int id) async {
    Database dbAppData = await db;
    List<Map> maps = await dbAppData.query(tableContacts, columns: [idColumn, nameContactColumn, phoneContactColumn, addressContactColumn, typeContactColumn], where: "idColumn = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<SocialProfile?> getSocialProfile(int id) async {
    Database dbAppData = await db;
    List<Map> maps = await dbAppData.query(tableSocialProfiles, columns: [idColumn, typeSocialProfileColumn, usernameSocialProfileColumn, emailidSocialProfileColumn, passwordSocialProfileColumn, profilelinkSocialProfileColumn], where: "idColumn = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      return SocialProfile.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<BankAccount?> getBankAccount(int id) async {
    Database dbAppData = await db;
    List<Map> maps = await dbAppData.query(tableBankAccounts, columns: [idColumn, banknameBankAccount, bankaddressBankAccount, typeBankAccount, fullnameBankAccount, phoneBankAccount, emailBankAccount, homeaddressBankAccount, ibanBankAccount], where: "idColumn = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      return BankAccount.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<BankCard?> getBankCard(int id) async {
    Database dbAppData = await db;
    List<Map> maps = await dbAppData.query(tableBankCards, columns: [idColumn, nameBankCard, holderBankCard, numberBankCard, expirydateBankCard, cvcBankCard, pinBankCard], where: "idColumn = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      return BankCard.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<PrivateText?> getPrivateText(int id) async {
    Database dbAppData = await db;
    List<Map> maps = await dbAppData.query(tablePrivateTexts, columns: [idColumn, subjectPrivateTextColumn, descriptionPrivateTextColumn], where: "idColumn = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      return PrivateText.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateContact(Contact contact) async {
    Database dbAppData = await db;
    return await dbAppData.update(tableContacts, contact.toMap(), where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<int> updateSocialProfile(SocialProfile socialProfile) async {
    Database dbAppData = await db;
    return await dbAppData.update(tableSocialProfiles, socialProfile.toMap(), where: "$idColumn = ?", whereArgs: [socialProfile.id]);
  }

  Future<int> updateBankAccount(BankAccount bankAccount) async {
    Database dbAppData = await db;
    return await dbAppData.update(tableBankAccounts, bankAccount.toMap(), where: "$idColumn = ?", whereArgs: [bankAccount.id]);
  }

  Future<int> updateBankCard(BankCard bankCard) async {
    Database dbAppData = await db;
    return await dbAppData.update(tableBankCards, bankCard.toMap(), where: "$idColumn = ?", whereArgs: [bankCard.id]);
  }

  Future<int> updatePrivateText(PrivateText privateText) async {
    Database dbAppData = await db;
    return await dbAppData.update(tablePrivateTexts, privateText.toMap(), where: "$idColumn = ?", whereArgs: [privateText.id]);
  }

  Future<int> deleteLockedApp(String package) async {
    Database dbAppData = await db;
    return await dbAppData.delete(tableLockedApps, where: "$packagenameLockedAppColumn = ?", whereArgs: [package]);
  }

  Future<int> deleteContact(int id) async {
    Database dbAppData = await db;
    return await dbAppData.delete(tableContacts, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> deleteSocialProfile(int id) async {
    Database dbAppData = await db;
    return await dbAppData.delete(tableSocialProfiles, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> deleteBankAccount(int id) async {
    Database dbAppData = await db;
    return await dbAppData.delete(tableBankAccounts, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> deleteBankCard(int id) async {
    Database dbAppData = await db;
    return await dbAppData.delete(tableBankCards, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> deletePrivateText(int id) async {
    Database dbAppData = await db;
    return await dbAppData.delete(tablePrivateTexts, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<List> getLockedApps() async {
    Database dbAppData = await db;
    List listMap = await dbAppData.rawQuery("SELECT * FROM $tableLockedApps");

    List<LockedApp> lockedAppsList = List.empty(growable: true);
    for (Map map in listMap) {
      lockedAppsList.add(LockedApp.fromMap(map));
    }
    return lockedAppsList;
  }

  Future<List> getContacts(String type) async {
    Database dbAppData = await db;
    List listMap = await dbAppData.rawQuery("SELECT * FROM $tableContacts");

    List<Contact> contactsList = List.empty(growable: true);
    if (type == "All") {
      for (Map map in listMap) {
        contactsList.add(Contact.fromMap(map));
      }
    } else {
      for (Map map in listMap) {
        if (Contact.fromMap(map).type == type) {
          contactsList.add(Contact.fromMap(map));
        }
      }
    }
    return contactsList;
  }

  Future<List> getSocialProfiles() async {
    Database dbAppData = await db;
    List listMap = await dbAppData.rawQuery("SELECT * FROM $tableSocialProfiles");

    List<SocialProfile> socialProfilesList = List.empty(growable: true);
    for (Map map in listMap) {
      socialProfilesList.add(SocialProfile.fromMap(map));
    }
    return socialProfilesList;
  }

  Future<List> getBankAccounts() async {
    Database dbAppData = await db;
    List listMap = await dbAppData.rawQuery("SELECT * FROM $tableBankAccounts");

    List<BankAccount> bankAccountsList = List.empty(growable: true);
    for (Map map in listMap) {
      bankAccountsList.add(BankAccount.fromMap(map));
    }
    return bankAccountsList;
  }

  Future<List> getBankCards() async {
    Database dbAppData = await db;
    List listMap = await dbAppData.rawQuery("SELECT * FROM $tableBankCards");

    List<BankCard> bankCardsList = List.empty(growable: true);
    for (Map map in listMap) {
      bankCardsList.add(BankCard.fromMap(map));
    }
    return bankCardsList;
  }

  Future<List> getPrivateTexts(String category) async {
    Database dbAppData = await db;
    List listMap = await dbAppData.rawQuery("SELECT * FROM $tablePrivateTexts");

    List<PrivateText> privateTextsList = List.empty(growable: true);
    if (category == "All") {
      for (Map map in listMap) {
        privateTextsList.add(PrivateText.fromMap(map));
      }
    } else {
      for (Map map in listMap) {
        if (PrivateText.fromMap(map).category == category) {
          privateTextsList.add(PrivateText.fromMap(map));
        }
      }
    }
    return privateTextsList;
  }
}
