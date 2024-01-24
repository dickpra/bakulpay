import 'package:bakulpay/src/controller/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';



Future setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("Token", value);
}

Future getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("Token");
}

Future removeToken() async {
  final SharedPreferences shared = await SharedPreferences.getInstance();
  return shared.remove("authToken");
}

Future removeUserFormLogin() async {
  final SharedPreferences shared = await SharedPreferences.getInstance();
  shared.remove("authToken");
  shared.remove("NickUser");
  shared.remove("UserId");
  shared.remove("UserPhoto");
  shared.remove("UserEmail");
}

Future<void> showAccessToken() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final accessToken = sharedPreferences.getString('UserId'); // Mengambil access_token dari SharedPreferences
  if (accessToken != null) {
    print('Access Token: $accessToken');
    // Lakukan apa yang Anda butuhkan dengan access_token di sini
  } else {
    print('Access Token tidak tersedia');
  }
}

Future<void> GetAllSync() async {
  PayController payController = Get.put(PayController());
  payController.getDataTransak();
  payController.getDataRate();
  payController.getDataMenu();
  payController.getDataRateTopup();
  payController.getPayment();
  payController.getPaymentwd();
  payController.getWithdraw();
  payController.getDataRateWd();
  payController.getPenggunaPreference();
  payController.getBlockchainUsdt();
}