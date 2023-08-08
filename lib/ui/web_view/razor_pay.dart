import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relife/providers/payment_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RazorPayWeb extends StatefulWidget {
  const RazorPayWeb({Key? key}) : super(key: key);

  @override
  State<RazorPayWeb> createState() => _RazorPayWebState();
}

class _RazorPayWebState extends State<RazorPayWeb> {
  double _progress = 0;
  late WebViewController controller;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
            ),
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: paymentProvider.paymentUrl,
                onWebViewCreated: (controller) {
                  controller.canGoForward();
                  controller.canGoBack();
                },
                onProgress: (progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
