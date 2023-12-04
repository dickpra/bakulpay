import 'dart:convert';

import 'package:http/http.dart' as http;

class postService{

  var sales_wait_url = 'http://192.168.18.33/api/sales/waiting';
  var sales_postwait_url = 'http://192.168.18.33/api/sales';
  var sales_proses_url = 'http://192.168.18.33/api/sales/proses';
  var sales_selesai_url = 'http://192.168.18.33/api/sales/selesai';

  var survei_baru_url = 'http://192.168.18.33/api/teknisi/waiting';
  var survei_proses_url = 'http://192.168.18.33/api/teknisi/proses';
  var survei_selesai_url = 'http://192.168.18.33/api/teknisi/selesai';

  var proses_url = 'https://651e567844a3a8aa4768226c.mockapi.io/';

  var login_url = 'http://192.168.18.33/api/login';



  Future<http.Response> getPostwait() async{
    // var url = Uri.parse('$proses_url/waiting');
    var url = Uri.parse('$sales_wait_url');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> getPostproses() async{
    var url = Uri.parse('$sales_proses_url');
    // var url = Uri.parse('$proses_url/proses');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> getPostSelesai() async{
    var url = Uri.parse('$sales_selesai_url');
    // var url = Uri.parse('$proses_url/proses');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> getPostById(int id) async{
    var url = Uri.parse('$sales_selesai_url/post/$id');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> CreatePostWaiting(dynamic data) async{

    dynamic headers = {
      'Content-Type' : 'application/json'
    };

    // var url = Uri.parse('$proses_url/waiting');
    var url = Uri.parse('$sales_postwait_url');
    var response = await http.post(url, headers: headers, body: jsonEncode(data));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> loginSales(dynamic data) async{

    dynamic headers = {
      'Content-Type' : 'application/json'
    };

    var url = Uri.parse('$login_url/login');
    var response = await http.post(url, headers: headers, body: jsonEncode(data));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> loginii(String email, String password) async {
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('https://reqres.in/api/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    return response;
  }

  Future<http.Response> get_survei_baru() async{
    // var url = Uri.parse('$proses_url/waiting');
    var url = Uri.parse('$sales_wait_url');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> get_survei_proses() async{
    // var url = Uri.parse('$proses_url/waiting');
    var url = Uri.parse('$sales_wait_url');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> get_survei_selesai() async{
    // var url = Uri.parse('$proses_url/waiting');
    var url = Uri.parse('$sales_wait_url');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

}