
import 'package:bakulpay/src/model/menu_model.dart';
import 'package:bakulpay/src/model/payment_model.dart';
import 'package:bakulpay/src/model/rate_model.dart';
import 'package:bakulpay/src/model/test_model.dart';
import 'package:bakulpay/src/model/wd_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_service.dart';
import 'package:http/http.dart' as http;


class PayController extends GetxController {
  var isTopUpSelected = true.obs;
  var isLoading = false.obs;
  final jsonDataTransaksi = <test_model>[].obs;
  final jsonDataRate = <rate_model>[].obs;
  final jsonDataMenu= <menu_model>[].obs;

  final selectedPaymentMethod = RxString('');

  final jsonRate = {}.obs;
  final jsonPembayaran = <payment_model>[].obs;
  final jsonWithdraw = <withdraw_model>[].obs;

  // final responPembayaran = {}.obs;

  final  responPembayaran =''.obs;

  var isPaypalSelected = false.obs;
  var isSkrillSelected = false.obs;
  var isPerfectMoneySelected = false.obs;
  var isPayeerSelected = false.obs;
  var isUsdtSelected = false.obs;
  var isBusdSelected = false.obs;
  var isVccSelected = false.obs;
  var isNetellerSelected = false.obs;

  void updateString(String? newValue) {
    selectedPaymentMethod.value = newValue!;
  }

  Future<void> KirimTopup (dynamic data) async {
    isLoading.value = true;
    final response = await ApiService().kirimTopup(data);

    print('Anjay $response');

    if (response != null) {

      var stringdata = response.toString();
      responPembayaran.value = stringdata;

      // isidata.value = waitingModel.fromJson(data);
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("Token", response.data!.token!);
      // Get.offAllNamed(dashboardSalesRoute);
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

    print('data $jsonDataWait');
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

  Future getPayment() async {

    final jsonDataWait = await ApiService().getPaymentApi();

    jsonPembayaran.assignAll(jsonDataWait);

  }

  Future getWithdraw() async {

    final jsonDataWait = await ApiService().getWithdrawApi();

    jsonWithdraw.assignAll(jsonDataWait);

  }



}