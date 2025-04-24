import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader/object/bank_card.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';

class NewBankCardScreen extends StatefulWidget {
  const NewBankCardScreen({Key? key}) : super(key: key);

  @override
  _NewBankCardScreenState createState() => _NewBankCardScreenState();
}

class _NewBankCardScreenState extends State<NewBankCardScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final _numberController = TextEditingController();
  final _holderController = TextEditingController();
  final _expirydateController = TextEditingController();
  final _cvcController = TextEditingController();
  final _pinController = TextEditingController();
  String _cardName = "American Express";

  void insertBankCardDatabase() async {
    String number = _numberController.text;
    String holder = _holderController.text;
    String expirydate = _expirydateController.text;
    String cvc = _cvcController.text;
    String pin = _pinController.text;

    if (number.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Card Number Required"),
      ));
    } else if (expirydate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Expiry Date Required"),
      ));
    } else if (cvc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("CVC Required"),
      ));
    } else if (pin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("PIN Required"),
      ));
    } else {
      BankCard bankCard = BankCard();
      bankCard.id = 9999999999; // Null ID
      bankCard.name = _cardName;
      bankCard.number = number;
      bankCard.holder = holder;
      bankCard.cvc = cvc;
      bankCard.pin = pin;
      bankCard.expirydate = expirydate;

      bankCard = await databaseHelper.insertBankCard(bankCard);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Bank Card Saved"),
      ));

      setState(() {
        // Empty Fields
        _numberController.text = "";
        _holderController.text = "";
        _expirydateController.text = "";
        _cvcController.text = "";
        _pinController.text = "";
        _cardName = "American Express";
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
          "Add Bank Card",
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
                        FlutterIcons.card_outline_mco,
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
                        value: _cardName,
                        icon: Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: theme.myAppMainColor,
                        ),
                        focusColor: theme.myAppMainColor,
                        dropdownColor: Colors.white,
                        underline: Container(),
                        isExpanded: true,
                        hint: Text(
                          "Card Name",
                          style: TextStyle(
                            color: theme.myAppMainColor,
                          ),
                        ),
                        items: <String>['American Express', 'Discover', 'Mastercard', 'Visa', 'Unionpay'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _cardName = value!;
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
                        maxLength: 15,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: _numberController,
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
                            "Card Number",
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
                        controller: _holderController,
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
                            "Card Holder",
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
                        maxLength: 8,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        controller: _expirydateController,
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
                            "Expiry Date",
                            style: TextStyle(
                              color: theme.myAppMainColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.date_range_outlined,
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
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: _cvcController,
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
                            "CVC Number",
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
                        maxLength: 4,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        controller: _pinController,
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
                            "PIN Code",
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
                    padding: const EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: () {
                        insertBankCardDatabase();
                      },
                      child: const Text(
                        'Save Bank Card',
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
