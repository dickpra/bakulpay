import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:bakulpay/src/page/dahsboard/home_widget/home.dart';
import 'package:bakulpay/src/router/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../../../controller/controller.dart';

class DetailMidtrans extends StatefulWidget {
  const DetailMidtrans({super.key, required this.data});
  final String data;

  @override
  State<DetailMidtrans> createState() => _DetailMidtransState();
}

class _DetailMidtransState extends State<DetailMidtrans> {
  final PayController payController = Get.put(PayController());
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  String getHtmlExample(String snapToken) {
    return '''
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <script src="https://app.sandbox.midtrans.com/snap/snap.js" data-client-key="YOUR_CLIENT_KEY"></script>
        </head>
        <body onload="setTimeout(function(){pay()}, 1000)">
          <script type="text/javascript">
            function pay() {
              snap.pay('$snapToken', {
                onSuccess: function(result) {
                  window.flutter_inappwebview.callHandler('paymentHandler', 'ok', result);
                },
                onPending: function(result) {
                  window.flutter_inappwebview.callHandler('paymentHandler', 'pending', result);
                },
                onError: function(result) {
                  window.flutter_inappwebview.callHandler('paymentHandler', 'error', result);
                },
                onClose: function() {
                  window.flutter_inappwebview.callHandler('paymentHandler', 'close', 'close');
                }
              });
            }
          </script>
        </body>
      </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              if (webViewController != null) {
                webViewController!.reload();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: InAppWebView(
          key: webViewKey,
          initialData: InAppWebViewInitialData(data: getHtmlExample(widget.data)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
            ),
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
            webViewController?.addJavaScriptHandler(
              handlerName: 'paymentHandler',
              callback: (args) {
                String status = args[0];
                String result = jsonEncode(args[1]); // Encode the JSON object to String
                // Handle different statuses here
                if (status == 'ok') {
                  print('status ok selesai');
                  // Get.offAllNamed(dashboard);
                  // Get.to(BuatPesanan);
                  Navigator.pop(context);
                  // payController.KirimBuktiTopupMidtrans();
                  print("testing status pembayaran $status");
                } else if (status == 'close') {
                  print('status close');
                  Navigator.pop(context);
                } else if (status == 'pending') {
                  print('status pending');
                  Navigator.pop(context);
                }else if( status == 'error'){

                }
              },
            );
          },
        ),
      ),
    );
  }
}
