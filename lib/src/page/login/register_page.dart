import 'dart:io';
import 'package:bakulpay/src/router/constant.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bakulpay/src/controller/login_controller.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/pembayaran_wd.dart';
import 'package:bakulpay/src/page/login/login.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  final loginController = Get.put(LoginController());

  LoginController registerController = Get.put(LoginController());
  bool passwordHide = true;
  bool passwordHide2 = true;
  File? _image;


  Future<void> pickGallery() async {
    final picker = ImagePicker();

    // Memilih sumber gambar (galeri atau kamera)
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> pickKamera() async {
    final picker = ImagePicker();

    // Memilih sumber gambar (galeri atau kamera)
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {

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
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text('Name', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(height: 5),
                if(widget.nama.isNotEmpty)
                textForm(_nameController..text = widget.nama,"Name",[FilteringTextInputFormatter.deny(RegExp(''))],TextInputType.text, 'Please enter your name','',false),
                if(widget.nama.isEmpty)
                textForm(_nameController,"Name",[FilteringTextInputFormatter.deny(RegExp(''))],TextInputType.text, 'Please enter your name','',false),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text('Username', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(height: 5),
                textForm(_usernameController,"Username",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'Please enter your username','',false),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text('Email', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(height: 5),
                if(widget.email.isEmpty)
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    // labelText: 'Email',
                    hintText: 'Email',
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
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Masukkan email yang benar!!';
                    } else if (!value.contains('.')) {
                      return 'Masukkan email yang benar!!';
                    }
                    return null;
                  },
                ),
                if(widget.email.isNotEmpty)
                TextFormField(
                  controller: _emailController..text = widget.email,
                  readOnly: widget.statusLoginGoolge,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    // labelText: 'Email',
                    hintText: 'Email',
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
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text('Phone Number', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(height: 5),
                textForm(_phoneController,"Phone Number",[FilteringTextInputFormatter.digitsOnly],TextInputType.number, 'Please enter your Phone Number','',false),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text('Password', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(height: 5),
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
                    hintText: 'Passsword',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                    } else if (value.length <= 6) {
                      return 'Password min 6 karakter';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text('Confirm Password', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(height: 5),
                TextFormField(
                  obscureText: passwordHide2,
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: passwordHide2 ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          passwordHide2 = !passwordHide2;
                        });
                      },),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    hintText: 'Confirm Passsword',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                    } else if (value.length <= 6) {
                      return 'Password min 6 karakter';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text('Pilih Foto Profil', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(height: 5),
                CircleAvatar(
                  radius: 80,
                  // backgroundImage: _image != null ? FileImage(_image!) : null,
                  backgroundColor: Color(0xff37398B),
                  child: ClipOval(
                    child:
                    _image == null ?
                    InkWell(

                      onTap: () { showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title:  Text('Pilih Foto'),
                          // content: Text('Pilih Foto'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Kamera'),
                              onPressed: () {
                                Navigator.pop(context);
                                // payController.pickImageKamera();
                                pickKamera();
                                // Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('Gallery'),
                              onPressed: () {
                                pickGallery();
                                // payController.pickImageGallery();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      }); },
                      child: const CircleAvatar(
                        radius: 80,
                        backgroundColor: Color(0xff37398B),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo,color: Colors.white,size: 60,),
                            Text('Add Photo',style: TextStyle(
                              color: Colors.white
                            ),)
                          ],
                        ),
                      ),
                    ):
                    InkWell(
                      onTap: () { showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title:  Text('Pilih Foto'),
                          // content: Text('Pilih Foto'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Kamera'),
                              onPressed: () {
                                Navigator.pop(context);
                                // payController.pickImageKamera();
                                pickKamera();
                                // Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('Gallery'),
                              onPressed: () {
                                pickGallery();
                                // payController.pickImageGallery();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      }); },
                      child: CircleAvatar(
                        radius: 80,
                        // backgroundImage: _image != null ? FileImage(_image!) : null,
                        backgroundColor: Color(0xff37398B),
                        child: ClipOval(
                            child: Image.file(
                              _image!,
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                        ),
                      ),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //
                //   },
                //   child: Text('Pilih Foto',style: TextStyle(
                //       color: Color(0xff37398B)
                //   ),),
                // ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) =>  Color(0xff37398B))
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Implement sign up logic
                      if(_image != null){
                        registerController.registerUserApp(context,_nameController.text, _usernameController.text, _emailController.text, _phoneController.text, _passwordController.text, _confirmPasswordController.text, _image!);
                      }else{
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "Warning",
                          desc: "Foto Tidak Boleh Kosong",
                          buttons: [
                            DialogButton(
                              color: Colors.red,
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                          // image: Image.asset("assets/images/usdt.png"),
                        ).show();
                      }
                    }
                  },
                  child:
                  Obx(() =>
                  loginController.isLoading.value ? CircularProgressIndicator():
                  Text('Sign In',style: TextStyle(color: Colors.white),),
                  ),
                  // Text('Create Account',style: TextStyle(
                  //   color: Colors.white
                  // ),),
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
                        Get.offAllNamed(loginApp);
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
