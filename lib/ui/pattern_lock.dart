import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_downloader/main.dart';

class PatternLockScreen extends StatefulWidget {
  const PatternLockScreen({Key? key}) : super(key: key);

  @override
  _PatternLockScreenState createState() => _PatternLockScreenState();
}

class _PatternLockScreenState extends State<PatternLockScreen> {
  late List<int>? pattern;
  bool isConfirm = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        color: theme.myAppMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: Text(
                isConfirm ? "Confirm Pattern" : "Master Pattern",
                style: const TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
            Flexible(
              child: PatternLock(
                selectedColor: Colors.white,
                notSelectedColor: Colors.grey,
                pointRadius: 12,
                onInputComplete: (List<int> input) async {
                  if (input.length < 3) {
                    Fluttertoast.showToast(msg: "Select At Least 03 Points", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 12.0);
                    return;
                  }
                  if (isConfirm) {
                    if (listEquals<int>(input, pattern)) {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      List<String>? stringCodes = pattern!.map((i) => i.toString()).toList();
                      prefs.setStringList("patterncodes", stringCodes);
                      Fluttertoast.showToast(msg: "Pattern Saved", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(msg: "Patterns Do Not Match", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                      setState(() {
                        pattern = null;
                        isConfirm = false;
                      });
                    }
                  } else {
                    setState(() {
                      pattern = input;
                      isConfirm = true;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
