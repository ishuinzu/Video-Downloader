import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader/object/bank_account.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';

class UpdateBankAccountScreen extends StatefulWidget {
  const UpdateBankAccountScreen({Key? key, required this.bankAccount}) : super(key: key);
  final BankAccount bankAccount;

  @override
  _UpdateBankAccountScreenState createState() => _UpdateBankAccountScreenState();
}

class _UpdateBankAccountScreenState extends State<UpdateBankAccountScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final _banknameController = TextEditingController();
  final _bankaddressController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _homeaddressController = TextEditingController();
  final _ibanController = TextEditingController();
  String _bankAccountType = "Current";

  @override
  void initState() {
    super.initState();

    _banknameController.text = widget.bankAccount.bankname;
    _bankaddressController.text = widget.bankAccount.bankaddress;
    _nameController.text = widget.bankAccount.fullname;
    _phoneController.text = widget.bankAccount.phone;
    _emailController.text = widget.bankAccount.email;
    _homeaddressController.text = widget.bankAccount.homeaddress;
    _ibanController.text = widget.bankAccount.iban;
    _bankAccountType = widget.bankAccount.type;
  }

  void insertBankAccountInDatabase() async {
    String bankname = _banknameController.text;
    String bankaddress = _bankaddressController.text;
    String type = _bankAccountType;
    String fullname = _nameController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;
    String homeaddress = _homeaddressController.text;
    String iban = _ibanController.text;

    if (bankname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Bank Name Required"),
      ));
    } else if (bankaddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Bank Address Required"),
      ));
    } else if (type.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Account Type Required"),
      ));
    } else if (fullname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Full Name Required"),
      ));
    } else if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email ID Required"),
      ));
    } else if (homeaddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Home Address Required"),
      ));
    } else if (iban.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("IBAN Required"),
      ));
    } else {
      BankAccount bankAccount = BankAccount();
      bankAccount.id = widget.bankAccount.id;
      bankAccount.bankaddress = bankaddress;
      bankAccount.bankname = bankname;
      bankAccount.email = email;
      bankAccount.fullname = fullname;
      bankAccount.homeaddress = homeaddress;
      bankAccount.iban = iban;
      bankAccount.type = type;
      bankAccount.phone = phone;

      int effectedRows = await databaseHelper.updateBankAccount(bankAccount);

      if (effectedRows > 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Bank Account Updated"),
        ));
      }
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
          "Update Bank Account",
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
                        FlutterIcons.bank_ant,
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
                        value: _bankAccountType,
                        icon: Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: theme.myAppMainColor,
                        ),
                        focusColor: theme.myAppMainColor,
                        dropdownColor: Colors.white,
                        underline: Container(),
                        isExpanded: true,
                        hint: Text(
                          "Account Type",
                          style: TextStyle(
                            color: theme.myAppMainColor,
                          ),
                        ),
                        items: <String>['Current', 'Certificate of Deposit', 'Money Markey', 'Savings'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _bankAccountType = value!;
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
                        maxLength: 128,
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        controller: _banknameController,
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
                            "Bank Name",
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Container(
                      color: Colors.white,
                      child: TextFormField(
                        maxLength: 128,
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        controller: _ibanController,
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
                            "IBAN",
                            style: TextStyle(
                              color: theme.myAppMainColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.numbers_outlined,
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
                            "Full Name",
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
                            "Phone Number",
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
                        maxLength: 64,
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: _emailController,
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
                            "Email ID",
                            style: TextStyle(
                              color: theme.myAppMainColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
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
                        keyboardType: TextInputType.streetAddress,
                        maxLines: 4,
                        controller: _bankaddressController,
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
                            "Bank Address",
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Container(
                      color: Colors.white,
                      child: TextFormField(
                        maxLength: 256,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        controller: _homeaddressController,
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
                            "Mailing Address",
                            style: TextStyle(
                              color: theme.myAppMainColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
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
                        insertBankAccountInDatabase();
                      },
                      child: const Text(
                        'Update Bank Account',
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
