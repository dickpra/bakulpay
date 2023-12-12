import 'package:bakulpay/src/page/dahsboard/dashboard.dart';
import 'package:bakulpay/src/page/login/login.dart';
import 'package:bakulpay/src/page/onboarding/onboarding.dart';
import 'package:bakulpay/src/router/constant.dart';
import 'package:get/get.dart';


final List<GetPage<dynamic>> routes = [
  GetPage(
    name: root,
    page: ()=> OnboardingScreen()
  ),
  // GetPage(
  //     name: MasukMilihRoute,
  //     page: ()=> Masuk()
  // ),
  GetPage(
      name: login,
      page: ()=> Login()
  ),
  GetPage(
      name: dashboard,
      page: ()=> DashBoard()
  ),

];