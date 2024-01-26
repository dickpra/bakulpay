import 'package:bakulpay/src/model/blockchain_model.dart';
import 'package:bakulpay/src/model/history_model.dart';
import 'package:bakulpay/src/service/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/menu_model.dart';
import 'package:bakulpay/src/model/payment_model.dart';
import 'package:bakulpay/src/model/rate_model.dart';
import 'package:bakulpay/src/model/test_model.dart';
import 'package:bakulpay/src/model/wd_model.dart';
import 'package:bakulpay/src/service/app_exception.dart';
import 'package:bakulpay/src/service/base_client.dart';
import 'package:bakulpay/src/service/base_controller.dart';
import 'package:bakulpay/src/setting/env.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class ApiService extends GetConnect with BaseController {
  PayController payController = Get.put(PayController());

  Future kirimBuktiWdApi(String nama, File foto) async {
    var idbayar = payController.responPembayaranWD.value;
    dynamic body = ({
      "nama": nama,
    });
    String? res;
    // var token = await getToken();
    final response = await BaseClient()
        .postMultipart(BASE_URL, '/payment/withdraw/$idbayar', body, '', foto)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        res = '{"success":"${apiError["success"]}","message":"${apiError["message"]}"}';
        Get.rawSnackbar(message: apiError["message"]);
      } else if (error is UnAuthorizedException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    print(body);
    final jdecodejson = json.decode(response);
    if (response != null) {

      return jdecodejson;
    } else {
      // final jsonDecoded = jsonDecode(res ?? "");
      // return jsonDecoded;
      return null;
    }
  }

  Future kirimBuktiWdApi2(String nama, File foto) async {
    var idbayar = payController.responPembayaranWD.value;
    dynamic body = ({
      "nama": nama,
    });
    String? res;
    // var token = await getToken();
    try {
      final response = await BaseClient()
          .postMultipart(BASE_URL, '/payment/withdraw/$idbayar', body, '', foto);

      print(body);

      if (response != null) {
        final jsonDecoded = jsonDecode(response);
        return jsonDecoded;
      } else {
        return null;
      }
    } catch (error) {
      handleError(error);
      return null;
    }
  }

  Future kirimBuktiTopApi(String nama, File foto) async {
    var idbayar = payController.responPembayaran.value;
    dynamic body = ({
      "nama": nama,
    });
    String? res;
    // var token = await getToken();
    final response = await BaseClient()
        .postMultipart(BASE_URL, '/payment/top_up/$idbayar', body, '', foto)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        res = '{"success":"${apiError["success"]}","message":"${apiError["message"]}"}';
        // Get.rawSnackbar(message: apiError["message"]);
      } else if (error is UnAuthorizedException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    print(body);
    if (response != null) {
      final jsonDecoded = jsonDecode(response);
      return jsonDecoded;
    } else {
      // final jsonDecoded = jsonDecode(res ?? "");
      // return jsonDecoded;
      return null;
    }
  }


  Future kirimWDapi (dynamic data) async{

    final response = await BaseClient()
        .post(BASE_URL, '/withdraw', data , "")
    // .post(URL_TEST, '/sales', data , "")
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else if (error is UnAuthorizedException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });

    // print('response $response');


    if (response != null) {
      var kirimIsi = jsonDecode(response);
      // print('Response status: ${kirimIsi.statusCode}');
      return kirimIsi;
    } else {
      return null;
    }

  }

  Future kirimTopup (dynamic data) async{

    final response = await BaseClient()
        .post(BASE_URL, '/top_up', data , "")
    // .post(URL_TEST, '/sales', data , "")
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else if (error is UnAuthorizedException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });

    // print('response $response');


    if (response != null) {
      var kirimIsi = jsonDecode(response);
      // print('Response status: ${kirimIsi.statusCode}');
      return kirimIsi;
    } else {
      return null;
    }

  }

  Future loginApi(String username, String password) async {
    dynamic body = ({"email": username, "password": password});
    final response = await BaseClient()
        .post(BASE_URL, '/login', body, "")
    // .post(URL_TEST, '/login', body, "")
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else if (error is UnAuthorizedException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    if (response != null) {
      var login = jsonDecode(response);
      return login;
    } else {
      return null;
    }
  }

  Future loginApiGoogle(String username) async {
    dynamic body = ({"email": username});
    final response = await BaseClient()
        .post(BASE_URL, '/login_gm', body, "")
    // .post(URL_TEST, '/login', body, "")
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else if (error is UnAuthorizedException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    if (response != null) {
      var login = jsonDecode(response);
      return login;
    } else {
      return null;
    }
  }

  Future registerApi(String name, String username, String email, String phone,String passsword, String confirm_pass,File fotoProfil) async {
    dynamic body = ({
      "name": name,
      "username": username,
      "email": email,
      "noHp": phone,
      "password": passsword,
      "confirm_password": confirm_pass,
    });
    final response = await BaseClient()
        .postMultipartReg(BASE_URL, '/register', body, "", fotoProfil)
    // .post(URL_TEST, '/login', body, "")
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else if (error is UnAuthorizedException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    if (response != null) {
      var login = jsonDecode(response);
      return login;
    } else {
      return null;
    }
  }

  Future<Iterable<model_history>> GetTransaksi() async{
    var idPgn = payController.respsonIdPengguna.value;
    var token = await getToken();
    final response = await BaseClient()
        .get(BASE_URL, '/history/$idPgn', '$token')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        // Get.rawSnackbar(message: apiError["message"]);
      }else if (error is ApiNotRespondingException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      }else if (error is FetchDataException) {
        var apiError = json.decode(error.message!);
        Get.rawSnackbar(message: apiError["message"]);
      }else {
        handleError(error);
      }
    });

    print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm $response");

    final jsonData = jsonDecode(response);

    if (response != null) {
      final List<dynamic> responseData = jsonData['data'];
      // print('responseData $responseData');
      // List<dynamic> transactions = [];
      // transactions.addAll(jsonData['data']['withdraws']);
      // transactions.addAll(jsonData['data']['topups']);
      // final List<dynamic> responseData = jsonData;

      // Mengonversi List<dynamic> menjadi Iterable<waitingModel>
      final Iterable<model_history> waitingModels = responseData.map((data) => model_history.fromJson(data));
      print("Itersble$waitingModels");
      return waitingModels;
    } else {
      var peler = response['data'].toString();
      print(' dasasdaadasdasdsa asdas dsa asdsa  as sa $peler');
      return response;
    }

  }
  Future<Iterable<rate_model>> getRate() async{

    final response = await BaseClient()
        .get(BASE_URL, '/rate',"")
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

    // final List<dynamic> responseData = jsonData['data'];
    final List<dynamic> responseData = jsonData;
    print('responseData $responseData');
    // final List<dynamic> responseData = jsonData;

    // Mengonversi List<dynamic> menjadi Iterable<waitingModel>
    final Iterable<rate_model> waitingModels = responseData.map((data) => rate_model.fromJson(data));
    print("Itersble$waitingModels");


    if (response != null) {
      return waitingModels;
    } else {
      return response;
    }

  }

  Future<Iterable<menu_model>> getMenu() async{

    final response = await BaseClient()
        .get(BASE_URL, '/payment/top%20up',"")
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

    print("responsemenu $response");

    final jsonData = jsonDecode(response);
    print("jsonData $jsonData");

    final List<dynamic> responseData = jsonData['data'];
    print('responseDataMenu $responseData');
    // final List<dynamic> responseData = jsonData;

    // Mengonversi List<dynamic> menjadi Iterable<waitingModel>
    final Iterable<menu_model> waitingModels = responseData.map((data) => menu_model.fromJson(data));
    print("Itersble$waitingModels");


    if (response != null) {
      return waitingModels;
    } else {
      return response;
    }

  }

  Future getRateWdApi() async{
    final response = await BaseClient()
        .get(BASE_URL, '/payment/withdraw',"")
    // .get(URL_MOCK2, '/test',"")
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

    final jsonData = jsonDecode(response);

    return jsonData;

  }

  Future getRateTop() async{
    final response = await BaseClient()
        .get(BASE_URL, '/payment/top%20up',"")
        // .get(URL_MOCK2, '/test',"")
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

    final jsonData = jsonDecode(response);
    return jsonData;
  }

  Future<Iterable<payment_model>> getPaymentApiWd() async{
    final response = await BaseClient()
        .get(BASE_URL, '/bankwd',"")
    // .get(URL_MOCK2, '/test',"")
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

    print("responsemenu $response");

    final jsonData = jsonDecode(response);
    print("jsonData $jsonData");

    final List<dynamic> responseData = jsonData['data'];
    // print('responseDataMenu $responseData');
    // final List<dynamic> responseData = jsonData;

    // Mengonversi List<dynamic> menjadi Iterable<waitingModel>
    final Iterable<payment_model> waitingModels = responseData.map((data) => payment_model.fromJson(data));
    print("Itersble$waitingModels");


    if (response != null) {
      return waitingModels;
    } else {
      return response;
    }

  }

  Future<Iterable<blockchain_model>> getBlochainUsdtApi() async{
    final response = await BaseClient()
        .get(BASE_URL, '/blockchain/usdt',"")
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

    print("responsemenu $response");

    final jsonData = jsonDecode(response);
    print("jsonData $jsonData");

    // final List<dynamic> responseData = jsonData['data'];
    // print('responseDataMenu $responseData');
    final List<dynamic> responseData = jsonData;

    // Mengonversi List<dynamic> menjadi Iterable<waitingModel>
    final Iterable<blockchain_model> waitingModels = responseData.map((data) => blockchain_model.fromJson(data));
    print("Itersble$waitingModels");


    if (response != null) {
      return waitingModels;
    } else {
      return response;
    }

  }

  Future<Iterable<payment_model>> getPaymentApi() async{
    final response = await BaseClient()
        .get(BASE_URL, '/metode_pembayaran',"")
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

    print("responsemenu $response");

    final jsonData = jsonDecode(response);
    print("jsonData $jsonData");

    final List<dynamic> responseData = jsonData['data'];
    // print('responseDataMenu $responseData');
    // final List<dynamic> responseData = jsonData;

    // Mengonversi List<dynamic> menjadi Iterable<waitingModel>
    final Iterable<payment_model> waitingModels = responseData.map((data) => payment_model.fromJson(data));
    print("Itersble$waitingModels");


    if (response != null) {
      return waitingModels;
    } else {
      return response;
    }

  }

  Future<Iterable<withdraw_model>> getWithdrawApi() async{
    final response = await BaseClient()
        .get(BASE_URL, '/payment/withdraw',"")
    // .get(URL_MOCK2, '/test',"")
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

    print("responsemenu $response");

    final jsonData = jsonDecode(response);
    print("jsonData $jsonData");

    final List<dynamic> responseData = jsonData['data'];
    // print('responseDataMenu $responseData');
    // final List<dynamic> responseData = jsonData;

    // Mengonversi List<dynamic> menjadi Iterable<waitingModel>
    final Iterable<withdraw_model> waitingModels = responseData.map((data) => withdraw_model.fromJson(data));
    print("Itersble$waitingModels");


    if (response != null) {
      return waitingModels;
    } else {
      return response;
    }

  }

}