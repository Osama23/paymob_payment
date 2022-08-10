import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paymob_payment/modules/register/register.dart';
import 'package:paymob_payment/shared/components/components.dart';
import 'package:paymob_payment/shared/components/constants.dart';
import 'package:paymob_payment/styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaCardScreen extends StatefulWidget {
  const VisaCardScreen({Key? key}) : super(key: key);

  @override
  State<VisaCardScreen> createState() => _VisaCardScreenState();
}

class _VisaCardScreenState extends State<VisaCardScreen> {
  // final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    print(
      'osama ###### https://accept.paymob.com/api/acceptance/iframes/432863?payment_token=$paymobFinalTokenCard',
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: WebView(
        initialUrl:
            'https://accept.paymob.com/api/acceptance/iframes/432863?payment_token=$paymobFinalTokenCard',
        javascriptMode: JavascriptMode.unrestricted,
        // onWebViewCreated: (WebViewController webViewController) {
        //   _controller.complete(webViewController);
        // },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        // navigationDelegate: (NavigationRequest request) {
        //   if (request.url.startsWith('https://www.youtube.com/')) {
        //     print('blocking navigation to $request}');
        //     return NavigationDecision.prevent;
        //   }
        //   print('allowing navigation to $request');
        //   return NavigationDecision.navigate;
        // },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Exit() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'Are you sure, you are done?',
              style: TextStyle(fontSize: 14, color: defColor),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    navigateAndFinish(context, RegisterScreen());
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}
