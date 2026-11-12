import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(
            "https://lookerstudio.google.com/embed/reporting/8b3ad982-aaba-4ff9-a36a-a692537bfa5c/page/kIV1C"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter WebView',
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
