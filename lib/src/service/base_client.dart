import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bakulpay/src/service/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class BaseClient {
  static const int TIME_OUT_DURATION = 20;
  //GET
  Future<dynamic> get(String baseUrl, String api, String token) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      if (token != "") {
        print({
          'url': uri.toString(),
          'token': token,
        });
        var response = await http.get(uri, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }).timeout(Duration(seconds: TIME_OUT_DURATION));
        return _processResponse(response);
      } else {
        var response = await http.get(uri, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }).timeout(Duration(seconds: TIME_OUT_DURATION));
        return _processResponse(response);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(
      String baseUrl, String api, dynamic payloadObj, String token) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      if (token != "") {
        var response = await http.post(uri, body: payload, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }).timeout(Duration(seconds: TIME_OUT_DURATION));
        return _processResponse(response);
      } else {
        var response = await http.post(uri, body: payload, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }).timeout(Duration(seconds: TIME_OUT_DURATION));
        return _processResponse(response);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> postMultipart(String baseUrl, String api, dynamic payload,
      String token, File file) async {
    var uri = Uri.parse(baseUrl + api);
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'multipart/form-data'
    };
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    try {
      request.fields['nama'] = payload['nama'];
      // request.fields['code'] = payload['code'];
      // // request.fields['type'] = payload['type'];
      // request.fields['status'] = payload['status'];
      // // request.fields['latitude'] = payload['latitude'];
      // // request.fields['longitude'] = payload['longitude'];
      // request.fields['note'] = payload['note'];
      if (file != null) {
        request.files.add(http.MultipartFile(
            "bukti_pembayaran",
            // ignore: deprecated_member_use
            http.ByteStream(file.openRead()).cast(),
            await file.length(),
            filename: path.basename(file.path)));
      } else {
        request.fields['bukti_pembayaran'] = "";
      }
      dynamic statusResponse;
      await request
          .send()
          .then((result) async {
        await http.Response.fromStream(result).then((response) {
          statusResponse = response;
        });
      })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});
      return _processResponse(statusResponse);
      // }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST REGISTER
  Future<dynamic> postMultipartReg(String baseUrl, String api, dynamic payload,
      String token, File file) async {
    var uri = Uri.parse(baseUrl + api);
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'multipart/form-data'
    };
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    try {
      request.fields['name'] = payload['name'];
      request.fields['username'] = payload['username'];
      request.fields['email'] = payload['email'];
      request.fields['noHp'] = payload['noHp'];
      request.fields['password'] = payload['password'];
      request.fields['confirm_password'] = payload['confirm_password'];
      if (file != null) {
        request.files.add(http.MultipartFile(
            "photo",
            // ignore: deprecated_member_use
            http.ByteStream(file.openRead()).cast(),
            await file.length(),
            filename: path.basename(file.path)));
      } else {
        request.fields['photo'] = "";
      }
      dynamic statusResponse;
      await request
          .send()
          .then((result) async {
        await http.Response.fromStream(result).then((response) {
          statusResponse = response;
        });
      })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});
      return _processResponse(statusResponse);
      // }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //DELETE
  Future<dynamic> delete(String baseUrl, String api, String token) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http.delete(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //PUT
  Future<dynamic> put(
      String baseUrl, String api, dynamic payloadObj, String token) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http.put(uri, body: payload, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }
  //OTHER

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}

