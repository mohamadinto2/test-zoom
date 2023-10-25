import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: InAppWebViewPage());
  }
}

class InAppWebViewPage extends StatefulWidget {
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("InAppWebView")),
        body: Column(children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse("https://learn.dev.intoexpert.com/")),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  // Enable camera and microphone access
                  mediaPlaybackRequiresUserGesture: false, // This allows autoplaying media content
                  javaScriptCanOpenWindowsAutomatically: true,
                ),
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true, // Use hybrid composition for Android
                ),
              ),
              onWebViewCreated: (controller) {
                // Add code to handle the WebView after creation
              },
              onReceivedServerTrustAuthRequest: (controller, request) {
                return Future.delayed(Duration(seconds: 1));
              },
            ),
          ),
        ]));
  }
}
