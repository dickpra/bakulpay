import 'package:bakulpay/src/controller/login_controller.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class BakulPaySignUpPage extends StatefulWidget {

  const BakulPaySignUpPage({super.key, required this.email});

  final String email;

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // backgroundColor: Colors.blue,
          title: Text(
            'Register Akun',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
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
                textForm(_nameController,"Name",[FilteringTextInputFormatter.deny(RegExp(''))],TextInputType.text, 'Please enter your name','',false),
                // TextFormField(
                //   controller: _nameController,
                //   decoration: InputDecoration(
                //     labelText: 'Name',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       )
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your name';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 20),
                textForm(_usernameController,"Username",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'Please enter your username','',false),
                // TextFormField(
                //   controller: _usernameController,
                //   decoration: InputDecoration(
                //     labelText: 'Username',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       )
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your username';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 20),
                textForm(_emailController..text = widget.email,"Email",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'Please enter your email','',false),
                // TextFormField(
                //   controller: _emailController..text = widget.email,
                //   decoration: InputDecoration(
                //     labelText: 'Email',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       )
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your email';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 20),
                textForm(_phoneController,"Phone Number",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'Please enter your Phone Number','',false),
                // TextFormField(
                //   controller: _phoneController,
                //   decoration: InputDecoration(
                //     labelText: 'Phone Number',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       )
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your phone number';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 20),
                textForm(_passwordController,"Password",[FilteringTextInputFormatter.deny(RegExp(''))],TextInputType.text, 'Please enter your Password','',true),
                SizedBox(height: 20),
                textForm(_confirmPasswordController,"Confirm Password",[FilteringTextInputFormatter.deny(RegExp(''))],TextInputType.text, 'Please enter your Password','',true),
                // TextFormField(
                //   controller: _passwordController,
                //   decoration: InputDecoration(
                //     labelText: 'Password',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       )
                //   ),
                //   obscureText: true,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your password';
                //     }
                //     return null;
                //   },
                // ),
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
