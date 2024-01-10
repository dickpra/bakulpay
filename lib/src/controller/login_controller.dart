import 'dart:convert';
import 'package:bakulpay/src/page/login/signup.dart';
import 'package:bakulpay/src/router/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Future<void> registerUserApp(String name, String username, String email, String phone,String passsword, String confirm_pass) async {
    isLoading.value = true;
    final response = await ApiService().registerApi(name,username,email,phone,passsword,confirm_pass);


    if (response != null) {
      login.value = login_model.fromJson(response);


      print('respon login $response');


      if (response['success'] == true){
        Get.offAllNamed(loginApp);
        Get.snackbar(
          backgroundColor: Colors.blue,
          'Informasi', // Judul SnackBar
          'Akun Selesai dibuat', // Isi SnackBar
          snackPosition: SnackPosition.BOTTOM, // Posisi SnackBar
          duration: Duration(seconds: 3), // Durasi tampilan SnackBar
          onTap: (snack) {
            // Aksi yang diambil ketika SnackBar ditekan
            print('SnackBar ditekan');
          },);
      }else if(response['message'] == 'Validation failed'){
        Get.defaultDialog(
          title: 'Password Tidak Cocok',
          content: (
              TextButton(
                onPressed: () { Get.back(); }, child: Text('Ok'),)),
        );
      }else{
        Get.snackbar(
          backgroundColor: Colors.blue,
          'Informasi', // Judul SnackBar
          'Akun sudah ada!', // Isi SnackBar
          snackPosition: SnackPosition.BOTTOM, // Posisi SnackBar
          duration: Duration(seconds: 3), // Durasi tampilan SnackBar
          onTap: (snack) {
            // Aksi yang diambil ketika SnackBar ditekan
            print('SnackBar ditekan');
          },);
      }

      isLoading.value = false;
    }else {
      isLoading.value = false;
    }
  }

  Future<void> loginUserApp(String email, String password) async {
    isLoading.value = true;
    final response = await ApiService().loginApi(email, password);


    if (response != null) {
      login.value = login_model.fromJson(response);



      print('respon login $response');


      if (response['success'] == true){
        final jsonResponse = response;
        final accessToken = jsonResponse['data']['access_token'];
        final Name = jsonResponse['data']['name'];
        final idUser = jsonResponse['data']['user_id'];
        final sharedPreferences = await SharedPreferences.getInstance();

        sharedPreferences.setString('authToken', accessToken);
        sharedPreferences.setString('NickUser', Name);
        sharedPreferences.setString('UserId', idUser);

        Get.offAllNamed(dashboard);
      }else{
        Get.defaultDialog(
          title: 'email / password salah',
          content: (
              TextButton(
                onPressed: () { Get.back(); }, child: Text('Ok'),)),
        );
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

  Future<void> loginGoogle(String email) async {
    isLoading.value = true;
    final response = await ApiService().loginApiGoogle(email);


    if (response != null) {
      login.value = login_model.fromJson(response);

      print('respon login $response');



      if (response['success'] == true){
        final jsonResponse = response;
        final accessToken = jsonResponse['data']['access_token'];
        final Name = jsonResponse['data']['name'];
        final idUser = jsonResponse['data']['user_id'];
        final sharedPreferences = await SharedPreferences.getInstance();

        sharedPreferences.setString('authToken', accessToken);
        sharedPreferences.setString('NickUser', Name);
        sharedPreferences.setString('UserId', idUser.toString());
        Get.offAllNamed(dashboard);
        print('peler sehat');
      }else{
        Get.to(BakulPaySignUpPage(email: email));
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
