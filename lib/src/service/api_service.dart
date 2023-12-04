
import 'dart:convert';
import 'package:bakulpay/src/model/test_model.dart';
import 'package:bakulpay/src/service/app_exception.dart';
import 'package:bakulpay/src/service/base_client.dart';
import 'package:bakulpay/src/service/base_controller.dart';
import 'package:bakulpay/src/setting/env.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class ApiService extends GetConnect with BaseController {

  Future<Iterable<test_model>> GetTransaksi() async{

    final response = await BaseClient()
        .get(URL_MOCK, '/proses',"")
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      }else if (error is ApiNotRespondingException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      }else {
        handleError(error);
      }
    });

    print("response $response");

    final jsonData = jsonDecode(response);
    print("jsonData $jsonData");

    final List<dynamic> responseData = jsonData;
    print('responseData $responseData');
    // final List<dynamic> responseData = jsonData;

    // Mengonversi List<dynamic> menjadi Iterable<waitingModel>
    final Iterable<test_model> waitingModels = responseData.map((data) => test_model.fromJson(data));
    print("Itersble$waitingModels");


    if (response != null) {
      return waitingModels;
    } else {
      return response;
    }

  }

}