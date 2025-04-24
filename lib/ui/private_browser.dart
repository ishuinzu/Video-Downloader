import 'package:flutter/material.dart';
import 'package:video_downloader/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivateBrowserScreen extends StatefulWidget {
  const PrivateBrowserScreen({Key? key}) : super(key: key);

  @override
  _PrivateBrowserScreenState createState() => _PrivateBrowserScreenState();
}

class _PrivateBrowserScreenState extends State<PrivateBrowserScreen> {
  late WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController.canGoBack()) {
          webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.myAppMainColor,
          centerTitle: false,
          leading: InkWell(
              onTap: () {
                webViewController.clearCache();
                CookieManager().clearCookies();
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close_outlined,
                color: Colors.white,
                size: 24,
              )),
          title: const Text(
            "Private Browser",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                webViewController.reload();
              },
              icon: const Icon(
                Icons.refresh_outlined,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                if (await webViewController.canGoBack()) {
                  webViewController.goBack();
                }
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "https://www.google.com",
          onWebViewCreated: (controller) {
            setState(() {
              webViewController = controller;
            });
          },
        ),
      ),
    );
  }
}
