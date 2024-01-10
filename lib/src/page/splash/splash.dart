import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../router/constant.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init() {
    Timer(const Duration(seconds: 2), () {
      getPref();
      // Get.offAndToNamed(loginRoute);
    });
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    if (token != '' && token != null) {
      Get.offAndToNamed(dashboard);
    } else {
      Get.offAndToNamed(onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: primaryColor,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.white, Colors.black54]

          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/LOGO.png',
                width: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
