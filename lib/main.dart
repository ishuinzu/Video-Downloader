import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_downloader/localization/language_constants.dart';
import 'package:video_downloader/localization/localization_stuff.dart';
import 'package:video_downloader/ui/splash_screen.dart';
import 'package:video_downloader/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  theme.setMainColor(await theme.getColor());
  await Firebase.initializeApp();
  await iUtils.checkingInternet();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

iUtils theme = iUtils();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int? storagePermissionCheck;
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  Future<int> checkStoragePermission() async {
    PermissionStatus result = await Permission.storage.status;
    setState(() {
      storagePermissionCheck = 1;
    });
    if (result.toString() == 'PermissionStatus.denied') {
      return 0;
    } else if (result.toString() == 'PermissionStatus.granted') {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    permissionHandler();
  }

  permissionHandler() async {
    if (await checkStoragePermission() == 0) {
      await [Permission.storage].request();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Center(
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(theme.myAppMainColor)),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'all_video_downloader_flutter',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: theme.myAppMainColor,
        ),
        locale: _locale,
        supportedLocales: const [Locale("en", "US"), Locale("ar", "SA"), Locale("hi", "IN")],
        localizationsDelegates: const [
          LocalizationStuff.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode && supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: const VideoDownloaderMain(),
      );
    }
  }
}

class VideoDownloaderMain extends StatelessWidget {
  const VideoDownloaderMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SplashScreen(),
        backgroundColor: Colors.white,
      ),
    );
  }
}
