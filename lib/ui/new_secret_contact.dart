import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader/object/contact.dart';

class NewSecretContactScreen extends StatefulWidget {
  const NewSecretContactScreen({Key? key}) : super(key: key);

  @override
  _NewSecretContactScreenState createState() => _NewSecretContactScreenState();
}

class _NewSecretContactScreenState extends State<NewSecretContactScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  String _phoneType = "Phone";

  void insertContactInDatabase() async {
    String name = _nameController.text;
    String phone = _phoneController.text;
    String address = _addressController.text;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Name Required"),
      ));
    } else if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Phone Required"),
      ));
    } else if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Address Required"),
      ));
    } else if (_phoneType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Phone Type Required"),
      ));
    } else {
      Contact contact = Contact();
      contact.id = 9999999999; // Null ID
      contact.name = name;
      contact.phone = phone;
      contact.address = address;
      contact.type = _phoneType;

      contact = await databaseHelper.insertContact(contact);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Secret Contact Saved"),
      ));

      setState(() {
        // Empty Fields
        _nameController.text = "";
        _phoneController.text = "";
        _addressController.text = "";
        _phoneType = "Phone";
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
          "Add Secret Contact",
          style: TextStyle(
            color: Colors.white,
          ),
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
                        Icons.person_add_alt_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
                    child: Container(
                      color: Colors.white,
                      child: TextFormField(
                        maxLength: 128,
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        controller: _nameController,
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
                            "Name",
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
                        maxLength: 15,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        controller: _phoneController,
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
                            "Phone",
                            style: TextStyle(
                              color: theme.myAppMainColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.phone_android_outlined,
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
                        maxLength: 256,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        controller: _addressController,
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
                            "Address",
                            style: TextStyle(
                              color: theme.myAppMainColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.location_city_outlined,
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
                        value: _phoneType,
                        icon: Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: theme.myAppMainColor,
                        ),
                        focusColor: theme.myAppMainColor,
                        dropdownColor: Colors.white,
                        underline: Container(),
                        isExpanded: true,
                        hint: Text(
                          "Phone Type",
                          style: TextStyle(
                            color: theme.myAppMainColor,
                          ),
                        ),
                        items: <String>['Phone', 'Office', 'Home', 'Work', 'Other'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _phoneType = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: () {
                        insertContactInDatabase();
                      },
                      child: const Text(
                        'Save Contact',
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
