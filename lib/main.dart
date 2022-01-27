

import 'package:botolota_final/screen/home_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    Fluttertoast.showToast(msg: "Connected with Mobile");
  } else if (connectivityResult == ConnectivityResult.wifi) {
    Fluttertoast.showToast(msg: "Connected with Wifi");
  } else {
    Fluttertoast.showToast(msg: "No internet Connection");
  }

  await Permission.camera.request();
  await Permission.location.isRestricted;

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),

    );
  }
}