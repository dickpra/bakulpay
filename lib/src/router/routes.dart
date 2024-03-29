import 'package:bakulpay/src/page/dahsboard/dashboard.dart';
import 'package:bakulpay/src/page/dahsboard/dashboard2.dart';
import 'package:bakulpay/src/page/login/login.dart';
import 'package:bakulpay/src/page/login/register_page.dart';
import 'package:bakulpay/src/page/onboarding/onboarding.dart';
import 'package:bakulpay/src/page/splash/splash.dart';
import 'package:bakulpay/src/page/topUp/topup_page.dart';
import 'package:bakulpay/src/router/constant.dart';
import 'package:get/get.dart';


final List<GetPage<dynamic>> routes = [
  GetPage(
    name: root,
    page: ()=> Root()
  ),
  GetPage(
      name: onboarding,
      page: ()=> OnboardingScreen()
  ),
  GetPage(
      name: loginApp,
      page: ()=> Login()
  ),
  // GetPage(
  //     name: dashboard,
  //     page: ()=> DashBoard()
  // ),
  GetPage(
      name: dashboard,
      page: ()=> DashboardNew()
  ),

  GetPage(
      name: topUp,
      page: ()=> Topup()
  ),


  GetPage(
      name: register,
      page: ()=> BakulPaySignUpPage(email: '', nama: '', statusLoginGoolge: false,)
  ),

];