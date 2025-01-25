import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.sellerclub.nahamta.com'));
  }

  Future<bool> _handleBackButtonPress() async {
    if (await _webViewController.canGoBack()) {
      // If WebView can go back, navigate back
      _webViewController.goBack();
      return false; // Do not exit the app
    }
    return true; // Exit the app if there's no back history
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackButtonPress, // Intercept the back button
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('WebView App'),
        ),
        body: WebViewWidget(controller: _webViewController),
      ),
    );
  }
}
