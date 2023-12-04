import 'dart:convert';
import 'package:bakulpay/src/page/dahsboard/dashboard.dart';
import 'package:bakulpay/src/page/login/signup.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
// final _postService = postService();



class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // LoginController loginController = Get.put(LoginController());

  // void postData() async{
  //
  //   dynamic data = {
  //     'email' : emailController.text,
  //     'pass' : passwordController.text,
  //   };
  //
  //   var res = await _postService.loginSales(data);
  //
  //
  //   if (res.statusCode == 201) {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => dsSales(title: '')));
  //   } else {
  //
  //     print('Gagal mengambil data dari API');
  //   }
  // }

  // Future<void> _login() async {
  //   final email = emailController.text;
  //   final password = passwordController.text;
  //
  //
  //   final response = await http.post(
  //     Uri.parse('http://192.168.18.33/api/login'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(<String, String>{'email': email, 'password': password}),
  //   );
  //
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     final accessToken = jsonResponse['access_token'];
  //     final sharedPreferences = await SharedPreferences.getInstance();
  //     sharedPreferences.setString('authToken', accessToken);
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     Get.offAllNamed(dashboardSalesRoute);
  //     // final sharedPreferences = await SharedPreferences.getInstance();
  //     // sharedPreferences.setString('authToken', 'yourAuthTokenHere'); // Gantilah dengan token autentikasi yang sesuai
  //   } else {
  //     // Gagal masuk, tampilkan pesan kesalahan
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Gagal Masuk'),
  //           content: Text('Email atau kata sandi salah. Silakan coba lagi.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

        // child: Scaffold(
        //   appBar: AppBar(
        //     title: const Text('Login Teknisi'),
        //     centerTitle: true,
        //     backgroundColor: const Color(0xff69cf9d),
        //   ),
        // bottom: true,
        // left: true,
        // right: true,
        // top: true,

          child: Scaffold(

            body:
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      // height: 120,
                        width: MediaQuery.sizeOf(context).width,
                        child: Image.asset('assets/images/LOGO.png')
                    ),
                    SizedBox(height: 50),
                    textForm(_emailController,"Masukkan E-Mail",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'Masukkan e-mail','@',false),

                    SizedBox(height: 20),
                    textForm(_passwordController,"Masukkan Password",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'isi password','',true),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Implement sign in logic

                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => dashBoard(),
                          ),
                        );
                      },
                      child: Text('Sign in'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Or'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BakulPaySignUpPage(),
                          ),
                        );
                        // TODO: Implement sign up with Google logic
                      },
                      child: Text('Sign Up'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
        )
    );
  }

  Widget formLogin(BuildContext context) {
    return Container(
      height: 60,
      width: 270,
      child: TextField(
          decoration: InputDecoration(
        hintText: "username",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        prefixIcon: const Icon(Icons.person),
      )),
    );
  }
}
