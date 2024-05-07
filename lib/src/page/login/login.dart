import 'dart:convert';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/controller/login_controller.dart';
import 'package:bakulpay/src/page/dahsboard/dashboard.dart';
import 'package:bakulpay/src/page/dahsboard/dashboard2.dart';
import 'package:bakulpay/src/page/login/goolgeLogin.dart';
import 'package:bakulpay/src/page/login/login2.dart';
import 'package:bakulpay/src/page/login/register_page.dart';
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

class UserController {
  bool isGoogleLogin = true;
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
// final _postService = postService();



class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final loginController = Get.put(LoginController());
  final UserController userController = UserController();

  bool passwordHide = true;

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
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text('Your email addres', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        // labelText: 'Email',
                        // hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
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
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Masukkan email yang benar!!';
                        } else if (!value.contains('.')) {
                          return 'Masukkan email yang benar!!';
                        }
                        return null;
                      },
                    ),
                    // textForm(_emailController,"Masukkan E-Mail",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.emailAddress, 'Masukkan e-mail','@',false),

                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text('Password', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: passwordHide,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: passwordHide ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passwordHide = !passwordHide;
                            });
                          },),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        // hintText: 'Passsword',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        labelStyle: TextStyle(
                          // color: Colors.blue,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Password';
                        } else if (value.length <= 5) {
                          return 'Password min 6 karakter';
                        }
                        return null;
                      },
                    ),
                    // textForm(_passwordController,"Masukkan Password",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'isi password','',true),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) =>  Color(0xFF7AA4F5))
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Implement sign in logic

                          loginController.loginUserApp(context,_emailController.text, _passwordController.text);
                          userController.isGoogleLogin = false;
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
                      Text('Sign In',style: TextStyle(color: Colors.white),),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        User? user = await signInWithGoogle();

                        if (user != null) {
                          print(user.photoURL);
                          print(user.displayName);

                          loginController.loginGoogle(user.email.toString(),user.displayName.toString(),user.photoURL.toString());
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
                            'Login With Google',style: TextStyle(color: Color(0xFF37398B))
                            // style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF37398B))
                      ),
                      onPressed: () {
                        Get.to(BakulPaySignUpPage(email: '', nama: '', statusLoginGoolge: false,));
                      },
                      child: Text('Register',style: TextStyle(color: Colors.white),),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     // Navigator.of(context).push(
                    //     //   MaterialPageRoute(
                    //     //     builder: (context) => BakulPaySignUpPage(email: '',),
                    //     //   ),
                    //     // );
                    //     // TODO: Implement sign up with Google logic
                    //     Get.to(BakulPaySignUpPage(email: '',));
                    //     // Get.off(() => BakulPaySignUpPage);
                    //   },
                    //   child: Text('Sign Up'),
                    // ),
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
