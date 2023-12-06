
import 'package:bakulpay/src/model/menu_model.dart';
import 'package:bakulpay/src/model/rate_model.dart';
import 'package:bakulpay/src/model/test_model.dart';
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


  var isPaypalSelected = false.obs;
  var isSkrillSelected = false.obs;
  var isPerfectMoneySelected = false.obs;
  var isPayeerSelected = false.obs;
  var isUsdtSelected = false.obs;
  var isBusdSelected = false.obs;
  var isVccSelected = false.obs;
  var isNetellerSelected = false.obs;


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



}