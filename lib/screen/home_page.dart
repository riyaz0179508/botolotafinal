import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


StreamSubscription? subscription;
bool loading = true;
class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (Platform.isAndroid) {
        WebView.platform = SurfaceAndroidWebView();
      }
    });
  }

  @override
  dispose() {
    super.dispose();

    subscription!.cancel();
  }

  int progress=0;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body:
              Builder(
                  builder: (context) => Stack(
                        children: [
                          WebView(
                            initialUrl:
                                "https://botolota.com/?fbclid=IwAR2ziqZvzB-HhR_I_AZRnDqKTgNBkSf9lwaw7q966gTHj_xnpO3omW9YUC8",
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              _controller.complete(webViewController);
                            },
                            onProgress: (int progress){

                            },
                            onPageFinished: (finish) {
                              setState(() {
                                loading = false;
                              });
                            },
                          ),
                          loading ? Center( child: CircularProgressIndicator(
                            backgroundColor:Colors.orange,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                            strokeWidth: 6,

                          ),)
                              : Stack(),
                        ],
                      ))),

    );
  }
}
