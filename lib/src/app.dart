import 'package:bakulpay/src/page/dahsboard/dashboard2.dart';
import 'package:bakulpay/src/page/login/login2.dart';
import 'package:bakulpay/src/page/onboarding/onboarding.dart';
import 'package:bakulpay/src/router/constant.dart';
import 'package:bakulpay/src/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bakulpay',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // home: Login2(),
      // home: DashboardNew(),

      getPages: routes,
      initialRoute:  root,
    );
  }
}