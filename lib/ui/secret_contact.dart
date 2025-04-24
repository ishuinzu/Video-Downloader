import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader/ui/new_secret_contact.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:video_downloader/ui/update_secret_contact.dart';
import 'package:url_launcher/url_launcher.dart';
import '../object/contact.dart';

class SecretContactScreen extends StatefulWidget {
  const SecretContactScreen({Key? key}) : super(key: key);

  @override
  _SecretContactScreenState createState() => _SecretContactScreenState();
}

class _SecretContactScreenState extends State<SecretContactScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Contact> contacts = List.empty(growable: true);
  String selectedPhoneType = "All";

  @override
  void initState() {
    super.initState();
    getAllContacts(selectedPhoneType);
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
          "Secret Contacts",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newSecretContactAction();
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
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                    ),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: <Widget>[
                          ActionChip(
                              backgroundColor: selectedPhoneType == "All" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'All',
                                style: TextStyle(
                                  color: selectedPhoneType == "All" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedPhoneType != "All") {
                                    selectedPhoneType = "All";
                                    contacts.clear();
                                    getAllContacts(selectedPhoneType);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedPhoneType == "Phone" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Phone',
                                style: TextStyle(
                                  color: selectedPhoneType == "Phone" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedPhoneType != "Phone") {
                                    selectedPhoneType = "Phone";
                                    contacts.clear();
                                    getAllContacts(selectedPhoneType);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedPhoneType == "Office" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Office',
                                style: TextStyle(
                                  color: selectedPhoneType == "Office" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedPhoneType != "Office") {
                                    selectedPhoneType = "Office";
                                    contacts.clear();
                                    getAllContacts(selectedPhoneType);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedPhoneType == "Home" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Home',
                                style: TextStyle(
                                  color: selectedPhoneType == "Home" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedPhoneType != "Home") {
                                    selectedPhoneType = "Home";
                                    contacts.clear();
                                    getAllContacts(selectedPhoneType);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedPhoneType == "Work" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Work',
                                style: TextStyle(
                                  color: selectedPhoneType == "Work" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedPhoneType != "Work") {
                                    selectedPhoneType = "Work";
                                    contacts.clear();
                                    getAllContacts(selectedPhoneType);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedPhoneType == "Other" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Other',
                                style: TextStyle(
                                  color: selectedPhoneType == "Other" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedPhoneType != "Other") {
                                    selectedPhoneType = "Other";
                                    contacts.clear();
                                    getAllContacts(selectedPhoneType);
                                  }
                                });
                              }),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: contacts.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            return dataCard(context, index);
                          },
                        )
                      : Center(
                          child: Text(
                            "No Secret Contact Found",
                            style: TextStyle(
                              color: theme.myAppMainColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  newSecretContactAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewSecretContactScreen()));
  }

  void getAllContacts(String phoneType) {
    databaseHelper.getContacts(phoneType).then((list) {
      setState(() {
        for (var element in list) {
          contacts.add(element);
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
                    FlutterIcons.contacts_ant,
                    color: theme.myAppMainColor,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Text(
                    contacts[index].name,
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
                  "Phone : " + contacts[index].phone,
                  style: TextStyle(
                    color: theme.myAppMainColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "Address : " + contacts[index].address,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSecretContactScreen(contact: contacts[index])));
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
                          int? effectedRows = await databaseHelper.deleteContact(contacts[index].id);
                          if (effectedRows > 0) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Record Deleted"),
                            ));
                            contacts.clear();
                            getAllContacts(selectedPhoneType);
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
                          launch("tel://${contacts[index].phone}");
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
