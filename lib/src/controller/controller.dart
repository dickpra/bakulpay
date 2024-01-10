import 'dart:io';
import 'package:bakulpay/src/model/history_model.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/bayarWd.dart';
import 'package:bakulpay/src/router/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bakulpay/src/model/menu_model.dart';
import 'package:bakulpay/src/model/payment_model.dart';
import 'package:bakulpay/src/model/rate_model.dart';
import 'package:bakulpay/src/model/test_model.dart';
import 'package:bakulpay/src/model/wd_model.dart';
import 'package:bakulpay/src/page/topUp/bayarTopUp.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_service.dart';
import 'package:http/http.dart' as http;


class PayController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);
  var isTopUpSelected = true.obs;
  var isLoading = false.obs;
  final jsonDataTransaksi = <model_history>[].obs;
  final jsonDataRate = <rate_model>[].obs;
  final jsonDataMenu= <menu_model>[].obs;

  final selectedPaymentMethod = RxString('');

  final jsonRate = {}.obs;
  final jsonRateWd = {}.obs;

  final jsonPembayaran = <payment_model>[].obs;
  final jsonPembayaranWd = <payment_model>[].obs;
  final jsonWithdraw = <withdraw_model>[].obs;

  // final responPembayaran = {}.obs;

  final  responPembayaran =''.obs;
  final  responPembayaranWD =''.obs;

  var isPaypalSelected = false.obs;
  var isSkrillSelected = false.obs;
  var isPerfectMoneySelected = false.obs;
  var isPayeerSelected = false.obs;
  var isUsdtSelected = false.obs;
  var isBusdSelected = false.obs;
  var isVccSelected = false.obs;
  var isNetellerSelected = false.obs;
  var  respsonIdPengguna =''.obs;
  var  respsonNamaPgn =''.obs;

  Future<void> getNamaPengguna() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('NickUser');
    if (accessToken != null) {
      respsonNamaPgn.value = accessToken.toString();
    }
  }
  Future<void> getidPengguna() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('UserId');
    if (accessToken != null) {
      respsonIdPengguna.value = accessToken.toString();
    }
  }

  Future<void> pickImageGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }
  Future<void> pickImageKamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  void updateString(String? newValue) {
    selectedPaymentMethod.value = newValue!;
  }

  Future<void> KirimBuktiWD (String nama, File bukti) async {
     isLoading.value = true;
    final response = await ApiService().kirimBuktiWdApi(nama, bukti);

    print('peler $response');

    if (response != null) {

      // isidata.value = waitingModel.fromJson(data);
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("Token", response.data!.token!);

      Get.snackbar(
        backgroundColor: Colors.blue,
        'Informasi', // Judul SnackBar
        'Berhasil Memesan!', // Isi SnackBar
        snackPosition: SnackPosition.BOTTOM, // Posisi SnackBar
        duration: Duration(seconds: 3), // Durasi tampilan SnackBar
        onTap: (snack) {
          // Aksi yang diambil ketika SnackBar ditekan
          print('SnackBar ditekan');
        },);

      Get.offAllNamed(dashboard);

      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> KirimWd (dynamic data) async {
    isLoading.value = true;
    final response = await ApiService().kirimWDapi(data);

    print('WD $response');

    if (response != null) {

      var stringdata = response['id_pembayaran'].toString();
      responPembayaranWD.value = stringdata;

      // isidata.value = waitingModel.fromJson(data);
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("Token", response.data!.token!);
      // Get.offAllNamed(dashboardSalesRoute);
      Get.to(() => BuatPesananWd(data: data));
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> KirimBuktiTopup (String nama, File bukti) async {
    isLoading.value = true;
    final response = await ApiService().kirimBuktiTopApi(nama, bukti);

    print('peler $response');

    if (response != null) {

      // isidata.value = waitingModel.fromJson(data);
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("Token", response.data!.token!);
      Get.toNamed(dashboard);
    //   Get.snackbar(
    //     backgroundColor: Colors.blue,
    //       'Informasi', // Judul SnackBar
    //       'Berhasil Memesan!', // Isi SnackBar
    //       snackPosition: SnackPosition.BOTTOM, // Posisi SnackBar
    //       duration: Duration(seconds: 3), // Durasi tampilan SnackBar
    // onTap: (snack) {
    // // Aksi yang diambil ketika SnackBar ditekan
    // print('SnackBar ditekan');
    // },);
      Get.dialog(
        SafeArea(
          child: Scaffold(
            body: Center(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Pembayaran Berhasil',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.check_circle_outline,
                        size: 130,
                        color: Colors.green,
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        }, child: Text(
                        'OK',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> KirimTopup (dynamic data) async {
    isLoading.value = true;
    final response = await ApiService().kirimTopup(data);

    print('Anjay $response');

    if (response != null) {

      var stringdata = response['id_pembayaran'].toString();
      responPembayaran.value = stringdata;

      // isidata.value = waitingModel.fromJson(data);
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("Token", response.data!.token!);
      // Get.offAllNamed(dashboardSalesRoute);
      Get.to(() => BuatPesanan(data: data));
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }


  Future getDataTransak() async {
    // Ambil dan proses data dari JSON, misalnya:
    final jsonDataWait = await ApiService().GetTransaksi();

    print('data $jsonDataWait');
    jsonDataTransaksi.assignAll(jsonDataWait);
  }
  Future getDataRate() async {
    // Ambil dan proses data dari JSON, misalnya:
    final jsonDataWait = await ApiService().getRate();

    print('rate $jsonDataWait');
    jsonDataRate.assignAll(jsonDataWait);
  }

  Future getDataMenu() async {
    // Ambil dan proses data dari JSON, misalnya:
    final jsonDataWait = await ApiService().getMenu();

    print('data $jsonDataWait');
    jsonDataMenu.assignAll(jsonDataWait);
  }

  Future getDataRateTopup() async {
    // Ambil dan proses data dari JSON, misalnya:
    final jsonDataWait = await ApiService().getRateTop();

    jsonRate.value = jsonDataWait;
    // print('topup $jsonDataWait');
  }

  Future getDataRateWd() async {
    // Ambil dan proses data dari JSON, misalnya:
    final jsonDataWait = await ApiService().getRateWdApi();

    jsonRateWd.value = jsonDataWait;
    // print('topup $jsonDataWait');
  }

  Future getPayment() async {

    final jsonDataWait = await ApiService().getPaymentApi();

    jsonPembayaran.assignAll(jsonDataWait);

  }
  Future getPaymentwd() async {

    final jsonDataWait = await ApiService().getPaymentApiWd();

    jsonPembayaranWd.assignAll(jsonDataWait);

  }

  Future getWithdraw() async {

    final jsonDataWait = await ApiService().getWithdrawApi();

    jsonWithdraw.assignAll(jsonDataWait);

  }



}