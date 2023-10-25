// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webview_flutter/webview_flutter.dart';

class MeetingScreen extends StatefulWidget {
  MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  WebViewController? controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36")
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) async {
            await Permission.microphone.request();
            await Permission.camera.request();
          },
          onPageFinished: (String url) async {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          "https://meet.jit.si/WeirdFlashesDifferentiateAdditionally",
        ),
      );
  
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WebViewWidget(
        controller: controller!,
      ),
    );
  }
}
