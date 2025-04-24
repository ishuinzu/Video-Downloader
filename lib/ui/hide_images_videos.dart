import 'package:flutter/material.dart';
import 'package:video_downloader/main.dart';

class HideImagesVideosScreen extends StatefulWidget {
  const HideImagesVideosScreen({Key? key}) : super(key: key);

  @override
  _HideImagesVideosScreenState createState() => _HideImagesVideosScreenState();
}

class _HideImagesVideosScreenState extends State<HideImagesVideosScreen> {
  late PageController pageController = PageController();
  int currentIndex = 0;

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
          "Hide Images/Videos",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: theme.myAppMainColor,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
