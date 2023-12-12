import 'package:bakulpay/src/model/menu_model.dart';
import 'package:bakulpay/src/model/payment_model.dart';
import 'package:bakulpay/src/model/rate_model.dart';
import 'package:bakulpay/src/model/test_model.dart';
import 'package:bakulpay/src/model/wd_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_service.dart';
import 'package:http/http.dart' as http;


class TopupController extends GetxController{
  var isLoading = false.obs;


  Future<void> isiFormpaket (dynamic data) async {
    isLoading.value = true;
    final response = await ApiService().kirimTopup(data);

    print('Anjay $response');

    if (response != null) {

      // isidata.value = waitingModel.fromJson(data);
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("Token", response.data!.token!);
      // Get.offAllNamed(dashboardSalesRoute);
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }
}