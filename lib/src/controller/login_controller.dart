import 'dart:convert';
import 'package:bakulpay/src/router/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bakulpay/src/model/login_model.dart';
import 'package:bakulpay/src/page/dahsboard/dashboard.dart';
import 'package:bakulpay/src/service/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var login = login_model().obs;

  Future<void> loginUserSales(String email, String password) async {
    isLoading.value = true;
    final response = await ApiService().loginApi(email, password);


    if (response != null) {
      login.value = login_model.fromJson(response);

      final jsonResponse = response;

      print('respon login $response');


      final accessToken = jsonResponse['data']['access_token'];
      final userName = jsonResponse['data']['name'];
      final sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.setString('authTokenSales', accessToken);
      sharedPreferences.setString('NameUser', userName);



      // if (roleName == 'Sales'){
      //   Get.offAllNamed(dashboardSalesRoute);
      // }else if (roleName == 'Teknisi'){
      //   Get.offAllNamed(dashboardTeknisiRoute);
      // }

      if (accessToken != null){
        Get.offAllNamed(dashboard);
      }


      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("Token", response.data!.token!);
      // Get.offAllNamed(DashBoard(user: User));
      // Get.offAllNamed(dashboard);
      isLoading.value = false;
    }else {
      isLoading.value = false;
    }
  }
}
