import 'dart:convert';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/controller/login_controller.dart';
import 'package:bakulpay/src/page/dahsboard/dashboard.dart';
import 'package:bakulpay/src/page/dahsboard/dashboard2.dart';
import 'package:bakulpay/src/page/login/goolgeLogin.dart';
import 'package:bakulpay/src/page/login/login2.dart';
import 'package:bakulpay/src/page/login/signup.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
// final _postService = postService();



class _LoginState extends State<Login> {

  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(

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

                          loginController.loginUserApp(_emailController.text, _passwordController.text);
                        }

                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => DashBoard(user: user),
                        //   ),
                        // );
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => DashBoard(),
                        //   ),
                        // );
                      },
                      child: Obx(() =>
                      loginController.isLoading.value ? CircularProgressIndicator():
                      Text('Sign In'),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        User? user = await signInWithGoogle();

                        if (user != null) {
                          print(user.email);
                          loginController.loginGoogle(user.email.toString());
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => DashBoard(),
                          //   ),
                          // );
                        } else {
                          print('Login gagal');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google-logo.png',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Login dengan Google',
                            // style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
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
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => BakulPaySignUpPage(email: '',),
                        //   ),
                        // );
                        // TODO: Implement sign up with Google logic
                        Get.to(BakulPaySignUpPage(email: '',));
                        // Get.off(() => BakulPaySignUpPage);
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
