import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:video_downloader/object/private_text.dart';

class NewPrivateTextScreen extends StatefulWidget {
  const NewPrivateTextScreen({Key? key}) : super(key: key);

  @override
  _NewPrivateTextScreenState createState() => _NewPrivateTextScreenState();
}

class _NewPrivateTextScreenState extends State<NewPrivateTextScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _textCategory = "Life";

  void insertPrivateTextInDatabase() async {
    String subject = _subjectController.text;
    String description = _descriptionController.text;

    if (subject.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Subject Required"),
      ));
    } else if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Descrpition Required"),
      ));
    } else {
      PrivateText privateText = PrivateText();
      privateText.id = 9999999999; // Null ID
      privateText.subject = subject;
      privateText.description = description;
      privateText.category = _textCategory;

      privateText = await databaseHelper.insertPrivateText(privateText);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Private Text Saved"),
      ));

      setState(() {
        // Empty Fields
        _subjectController.text = "";
        _descriptionController.text = "";
        _textCategory = "Life";
      });
    }
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
          "Add Private Text",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/backImage.jpg'), fit: BoxFit.cover),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: theme.myAppMainColor,
                      radius: 48,
                      child: const Icon(
                        FlutterIcons.pencil_lock_outline_mco,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.myAppMainColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 6, 10, 8),
                      child: DropdownButton<String>(
                        style: TextStyle(
                          color: theme.myAppMainColor,
                        ),
                        value: _textCategory,
                        icon: Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: theme.myAppMainColor,
                        ),
                        focusColor: theme.myAppMainColor,
                        dropdownColor: Colors.white,
                        underline: Container(),
                        isExpanded: true,
                        hint: Text(
                          "Text Category",
                          style: TextStyle(
                            color: theme.myAppMainColor,
                          ),
                        ),
                        items: <String>['Life', 'Love', 'Personal', 'Work', 'Travel', 'Other'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _textCategory = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Container(
                      color: Colors.white,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        maxLength: 256,
                        controller: _subjectController,
                        cursorColor: theme.myAppMainColor,
                        style: TextStyle(
                          color: theme.myAppMainColor,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: theme.myAppMainColor,
                              width: 2.0,
                            ),
                          ),
                          label: Text(
                            "Subject",
                            style: TextStyle(
                              color: theme.myAppMainColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: theme.myAppMainColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.myAppMainColor,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.myAppMainColor,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Container(
                      color: Colors.white,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        maxLength: 1200,
                        controller: _descriptionController,
                        cursorColor: theme.myAppMainColor,
                        style: TextStyle(
                          color: theme.myAppMainColor,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: theme.myAppMainColor,
                              width: 2.0,
                            ),
                          ),
                          label: Text(
                            "Private Text",
                            style: TextStyle(
                              color: theme.myAppMainColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.text_format,
                            color: theme.myAppMainColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.myAppMainColor,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.myAppMainColor,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: () {
                        insertPrivateTextInDatabase();
                      },
                      child: const Text(
                        'Save Private Text',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: theme.myAppMainColor,
                      elevation: 0,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
