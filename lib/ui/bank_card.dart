import 'package:video_downloader/database/database_helper.dart';
import 'package:video_downloader/main.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader/object/bank_card.dart';
import 'package:video_downloader/ui/new_bank_card.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class BankCardScreen extends StatefulWidget {
  const BankCardScreen({Key? key}) : super(key: key);

  @override
  _BankCardScreenState createState() => _BankCardScreenState();
}

class _BankCardScreenState extends State<BankCardScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<BankCard> bankCards = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    getBankCards();
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
          "Bank Cards",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newBankCardAction();
        },
        child: const Icon(Icons.add),
        backgroundColor: theme.myAppMainColor,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/backImage.jpg'), fit: BoxFit.cover),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: theme.myAppMainColor.withOpacity(0.05),
            child: bankCards.isNotEmpty
                ? ListView.builder(
                    itemCount: bankCards.length,
                    itemBuilder: (context, index) {
                      return dataCard(context, index);
                    },
                  )
                : Center(
                    child: Text(
                      "No Bank Card Found",
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

  newBankCardAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewBankCardScreen()));
  }

  void getBankCards() {
    databaseHelper.getBankCards().then((list) {
      setState(() {
        for (var element in list) {
          bankCards.add(element);
        }
      });
    });
  }

  Widget dataCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(context, index);
      },
      child: CreditCardWidget(
        onCreditCardWidgetChange: (card) {},
        cardNumber: bankCards[index].number,
        expiryDate: bankCards[index].expirydate,
        cardHolderName: bankCards[index].holder,
        cvvCode: bankCards[index].cvc,
        showBackView: false,
        cardBgColor: Colors.black54,
        obscureCardNumber: false,
        obscureCardCvv: false,
        isHolderNameVisible: true,
        height: 180,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
        width: MediaQuery.of(context).size.width,
        isChipVisible: true,
        isSwipeGestureEnabled: true,
        animationDuration: const Duration(milliseconds: 600),
        cardType: getCardType(bankCards[index].name),
      ),
    );
  }

  getCardType(String name) {
    if (name == "American Express") {
      return CardType.americanExpress;
    } else if (name == "Discover") {
      return CardType.discover;
    } else if (name == "Mastercard") {
      return CardType.mastercard;
    } else if (name == "Visa") {
      return CardType.visa;
    } else if (name == "Unionpay") {
      return CardType.otherBrand;
    }
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
                          int? effectedRows = await databaseHelper.deleteContact(bankCards[index].id);
                          if (effectedRows > 0) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Record Deleted"),
                            ));
                            bankCards.clear();
                            getBankCards();
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
                          launch("tel://${bankCards[index].pin}");
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
