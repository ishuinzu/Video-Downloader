import 'package:flutter/material.dart';
import 'package:video_downloader/ui/imageScreen.dart';
import 'package:video_downloader/ui/videoScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
// Passed BuildContext in function.
        bottomNavigationBar: TabBarView(
      children: [
        ImageScreen(),
        const VideoScreen(),
      ],
    ));
  }
}
