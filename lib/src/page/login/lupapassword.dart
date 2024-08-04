import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:bakulpay/src/router/constant.dart';
import 'package:bakulpay/src/service/preference.dart';
import 'package:bakulpay/src/setting/env.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../router/constant.dart';
import '../../service/preference.dart';

class lupaPasswordPage extends StatefulWidget {
  const lupaPasswordPage({super.key});

  @override
  State<lupaPasswordPage> createState() => _lupaPasswordPageState();
}

class _lupaPasswordPageState extends State<lupaPasswordPage> {

  final _emailController = TextEditingController();

  String text = '';
  bool message = false;
  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.blue,
        // title: Text(
        //   'Lupa Password',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.help_center,size: 100, color: Colors.blue,),
                  Text('Reset Password', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold
                  ),),
                  Text('Masukkan email anda di bawah ini', style: TextStyle(
                      fontSize: 15,
                  ),),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      // labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelStyle: TextStyle(
                        // color: Colors.blue,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                  ),
                  // SizedBox(height: 20,),
                  if(message == true)
                  Container(child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text('${text}', style: TextStyle(
                        fontSize: 13,
                        color: isSuccess ? Colors.green : Colors.red,
                      )),
                    ],
                  )),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xff37398B)),
                      minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 45)), // Panjang penuh (infinity) dan tinggi 50
                    ),
                    onPressed: () {
                      print(text);
                      updateUserProfile(_emailController.text);
                    },
                    child: Text(
                      'Kirim Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Or'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Punya akun?'),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement sign in logic
                          Get.offAllNamed(loginApp);
                        },
                        child: Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ), // Replace with the path to your warning image
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateUserProfile(String email) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/password/reset'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Pesan: ${data}');
      setState(() {
        if (data['success'] == true) {
          message = true;
          isSuccess = true;
          text = data['message'];
          print(text);
        } else {
          message = true;
          text = data['message'];
          print('memek $text');
        }
      });
    } else {
      final data = jsonDecode(response.body);
      setState(() {
        message = true;
        text = data['message'];
        print('Failed: ${response.body}');
      });
    }
  }
}
