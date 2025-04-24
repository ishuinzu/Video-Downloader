import 'dart:io';

import 'package:flutter/material.dart';

class ImageOpener extends StatefulWidget {
  final String videoFile;

  const ImageOpener(this.videoFile);

  @override
  _ImageOpenerState createState() => _ImageOpenerState();
}

class _ImageOpenerState extends State<ImageOpener> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InteractiveViewer(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Image.file(
                    File(widget.videoFile),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: IconButton(
                onPressed: () {
                  print('hello');
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
