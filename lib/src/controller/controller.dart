
import 'package:bakulpay/src/model/test_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_service.dart';
import 'package:http/http.dart' as http;


class PayController extends GetxController {
  var isTopUpSelected = true.obs;
  var isLoading = false.obs;
  final jsonDataTransaksi = <test_model>[].obs;

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





}