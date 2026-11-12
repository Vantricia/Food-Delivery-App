import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript mode
      ..loadRequest(Uri.parse(
          "https://lookerstudio.google.com/embed/reporting/8b3ad982-aaba-4ff9-a36a-a692537bfa5c/page/kIV1C"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: WebViewWidget(controller: controller)),
    );
  }
}
