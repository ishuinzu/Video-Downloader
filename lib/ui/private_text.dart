import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader/object/private_text.dart';
import 'package:video_downloader/ui/new_private_text.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivateTextScreen extends StatefulWidget {
  const PrivateTextScreen({Key? key}) : super(key: key);

  @override
  _PrivateTextScreenState createState() => _PrivateTextScreenState();
}

class _PrivateTextScreenState extends State<PrivateTextScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<PrivateText> privateTexts = List.empty(growable: true);
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    getPrivateTexts(selectedCategory);
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
          "Private Texts",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newPrivateTextAction();
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
                              backgroundColor: selectedCategory == "All" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'All',
                                style: TextStyle(
                                  color: selectedCategory == "All" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedCategory != "All") {
                                    selectedCategory = "All";
                                    privateTexts.clear();
                                    getPrivateTexts(selectedCategory);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedCategory == "Life" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Life',
                                style: TextStyle(
                                  color: selectedCategory == "Life" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedCategory != "Life") {
                                    selectedCategory = "Life";
                                    privateTexts.clear();
                                    getPrivateTexts(selectedCategory);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedCategory == "Love" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Love',
                                style: TextStyle(
                                  color: selectedCategory == "Love" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedCategory != "Love") {
                                    selectedCategory = "Love";
                                    privateTexts.clear();
                                    getPrivateTexts(selectedCategory);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedCategory == "Personal" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Personal',
                                style: TextStyle(
                                  color: selectedCategory == "Personal" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedCategory != "Personal") {
                                    selectedCategory = "Personal";
                                    privateTexts.clear();
                                    getPrivateTexts(selectedCategory);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedCategory == "Work" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Work',
                                style: TextStyle(
                                  color: selectedCategory == "Work" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedCategory != "Work") {
                                    selectedCategory = "Work";
                                    privateTexts.clear();
                                    getPrivateTexts(selectedCategory);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedCategory == "Travel" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Travel',
                                style: TextStyle(
                                  color: selectedCategory == "Travel" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedCategory != "Travel") {
                                    selectedCategory = "Travel";
                                    privateTexts.clear();
                                    getPrivateTexts(selectedCategory);
                                  }
                                });
                              }),
                          const SizedBox(width: 8.0),
                          ActionChip(
                              backgroundColor: selectedCategory == "Other" ? theme.myAppMainColor : Colors.white,
                              label: Text(
                                'Other',
                                style: TextStyle(
                                  color: selectedCategory == "Other" ? Colors.white : theme.myAppMainColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedCategory != "Other") {
                                    selectedCategory = "Other";
                                    privateTexts.clear();
                                    getPrivateTexts(selectedCategory);
                                  }
                                });
                              }),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: privateTexts.isNotEmpty
                      ? MasonryGridView.count(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          crossAxisCount: 2,
                          itemCount: privateTexts.length,
                          itemBuilder: (context, index) {
                            return dataCard(context, index);
                          },
                        )
                      : Center(
                          child: Text(
                            "No Private Text Found",
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

  newPrivateTextAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPrivateTextScreen()));
  }

  void getPrivateTexts(String selectedCategory) {
    databaseHelper.getPrivateTexts(selectedCategory).then((list) {
      setState(() {
        for (var element in list) {
          privateTexts.add(element);
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
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Text(
                privateTexts[index].subject,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: theme.myAppMainColor,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                privateTexts[index].description,
                style: TextStyle(
                  fontSize: 14.0,
                  color: theme.myAppMainColor,
                ),
              ),
            ],
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
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSecretContactScreen(contact: contacts[index])));
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
                          int? effectedRows = await databaseHelper.deletePrivateText(privateTexts[index].id);
                          if (effectedRows > 0) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Private Text Deleted"),
                            ));
                            privateTexts.clear();
                            getPrivateTexts(selectedCategory);
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
                          launch("tel://${privateTexts[index].category}");
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
