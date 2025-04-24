import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader/object/bank_account.dart';
import 'package:video_downloader/ui/new_bank_account.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_downloader/ui/update_bank_account.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({Key? key}) : super(key: key);

  @override
  _BankAccountScreenState createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<BankAccount> bankAccounts = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    getBankAccounts();
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
          "Bank Accounts",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newBankAccountAction();
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
            child: bankAccounts.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: bankAccounts.length,
                    itemBuilder: (context, index) {
                      return dataCard(context, index);
                    },
                  )
                : Center(
                    child: Text(
                      "No Bank Account Found",
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

  newBankAccountAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewBankAccountScreen()));
  }

  void getBankAccounts() {
    databaseHelper.getBankAccounts().then((list) {
      setState(() {
        for (var element in list) {
          bankAccounts.add(element);
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
                  child: Icon(
                    FlutterIcons.bank_ant,
                    color: theme.myAppMainColor,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Text(
                    bankAccounts[index].bankname,
                    style: TextStyle(
                      color: theme.myAppMainColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    bankAccounts[index].type + " Account",
                    style: TextStyle(
                      color: theme.myAppMainColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "IBAN : " + bankAccounts[index].iban,
                  style: TextStyle(
                    color: theme.myAppMainColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "Bank Address : " + bankAccounts[index].bankaddress,
                  style: TextStyle(
                    color: theme.myAppMainColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "Full Name : " + bankAccounts[index].fullname,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateBankAccountScreen(bankAccount: bankAccounts[index])));
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
                          int? effectedRows = await databaseHelper.deleteBankAccount(bankAccounts[index].id);
                          if (effectedRows > 0) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Bank Account Deleted"),
                            ));
                            bankAccounts.clear();
                            getBankAccounts();
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
                        onPressed: () {
                          Navigator.pop(context);
                          launch("tel://${bankAccounts[index].phone}");
                        },
                        textColor: Colors.white,
                        child: Icon(
                          FlutterIcons.phone_call_fea,
                          color: theme.myAppMainColor,
                          size: 24,
                        ),
                        shape: const CircleBorder(),
                      ),
                      Text(
                        "Call",
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
