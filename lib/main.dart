import 'package:flutter/material.dart';
import 'webview.dart';
import 'phorjapan.dart';
import 'japanFolder/webviewJP.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'api_service.dart';
import 'japanFolder/api_serviceJP.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? phOrJp = prefs.getString('phorjp');
  String? deviceId = await UniqueIdentifier.serial;
  ApiService.setupHttpOverrides();
  ApiServiceJP.setupHttpOverrides();
  String initialRoute;
  if (phOrJp == "ph") {
    initialRoute = '/webView';
  } else if (phOrJp == "jp") {
    initialRoute = '/webViewJP';
  } else {
    initialRoute = '/phorjapan';
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Out Approval',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: initialRoute,
      routes: {
        '/phorjapan': (context) => PhOrJpScreen(),
        '/webView': (context) => SoftwareWebViewScreen(linkID: 42),
        '/webViewJP': (context) => SoftwareWebViewScreenJP(linkID: 42),
      },
    );
  }
}