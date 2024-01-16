import 'package:bakulpay/src/controller/login_controller.dart';
import 'package:bakulpay/src/page/login/login.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class BakulPaySignUpPage extends StatefulWidget {

  const BakulPaySignUpPage({super.key, required this.email, required this.nama, required this.statusLoginGoolge});

  final String email;
  final String nama;
  final bool statusLoginGoolge;


  @override
  _BakulPaySignUpPageState createState() => _BakulPaySignUpPageState();
}

class _BakulPaySignUpPageState extends State<BakulPaySignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  LoginController registerController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    bool isPasswordValid = false;

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   // backgroundColor: Colors.blue,
        //   title: Text(
        //     'Register Akun',
        //     style: TextStyle(
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        body: Padding(
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
                textForm(_nameController..text = widget.nama,"Name",[FilteringTextInputFormatter.deny(RegExp(''))],TextInputType.text, 'Please enter your name','',false),

                SizedBox(height: 20),
                textForm(_usernameController,"Username",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'Please enter your username','',false),

                SizedBox(height: 20),
                // textForm(_emailController..text = widget.email,"Email",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'Please enter your email','@',false),
                TextFormField(
                  controller: _emailController..text = widget.email,
                  readOnly: widget.statusLoginGoolge,
                  decoration: InputDecoration(

                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelStyle: TextStyle(
                      // color: Colors.blue,
                    ),
                  ),
                  keyboardType: TextInputType.text,
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
                SizedBox(height: 20),
                textForm(_phoneController,"Phone Number",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'Please enter your Phone Number','',false),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: 'Passsword',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelStyle: TextStyle(
                      // color: Colors.blue,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Password';
                    } else if (value.length <= 6) {
                      return 'Password min 6 karakter';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: 'Confirm Passsword',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelStyle: TextStyle(
                      // color: Colors.blue,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Password';
                    } else if (value.length <= 6) {
                      return 'Password min 6 karakter';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Implement sign up logic
                      registerController.registerUserApp(_nameController.text, _usernameController.text, _emailController.text, _phoneController.text, _passwordController.text, _confirmPasswordController.text);
                    }
                  },
                  child: Text('Create Account'),
                ),
                // SizedBox(height: 20),
                // Row(
                //   children: [
                //     Expanded(child: Divider()),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //       child: Text('Or'),
                //     ),
                //     Expanded(child: Divider()),
                //   ],
                // ),
                // SizedBox(height: 20),
                // TextButton(
                //   onPressed: () {
                //     // TODO: Implement sign up with Google logic
                //   },
                //   child: Text('Sign Up with Google'),
                // ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have an account?'),
                    SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement sign in logic
                      },
                      child: Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
