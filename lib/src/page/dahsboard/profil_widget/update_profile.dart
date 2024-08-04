import 'dart:convert';
import 'dart:io';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/page/dahsboard/dashboard.dart';
import 'package:bakulpay/src/router/constant.dart';
import 'package:bakulpay/src/service/preference.dart';
import 'package:bakulpay/src/setting/env.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bakulpay/src/controller/login_controller.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/pembayaran_wd.dart';
import 'package:bakulpay/src/page/login/login.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdateProfilePage extends StatefulWidget {

  const UpdateProfilePage({super.key, required this.email, required this.nama, required this.noHp, required this.photoUser});

  final String email;
  final String nama;
  final String noHp;
  final String photoUser;
  // final bool statusLoginGoolge;


  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final payController = Get.put(PayController());

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
        appBar: AppBar(
          centerTitle: true,
          // backgroundColor: Colors.blue,
          title: Text(
            'Update Profile',
            style: TextStyle(
              color: Colors.black,
                fontWeight: FontWeight.bold,

            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // SizedBox(
                //   // height: 120,
                //     width: MediaQuery.sizeOf(context).width,
                //     child: Image.asset('assets/images/LOGO.png')
                // ),
                // const Row(
                //   children: [
                //     SizedBox(width: 5),
                //     Text('Pilih Foto Profil', style: TextStyle(
                //         fontSize: 18, fontWeight: FontWeight.bold
                //     ),),
                //   ],
                // ),
                // const SizedBox(height: 5),
                //
                // CircleAvatar(
                //   radius: 80,
                //   // backgroundImage: _image != null ? FileImage(_image!) : null,
                //   backgroundColor: Colors.grey,
                //   child: ClipOval(
                //     child:
                //     _image == null ?
                //     InkWell(
                //       onTap: () { showDialog(context: context, builder: (BuildContext context){
                //         return AlertDialog(
                //           title:  Text('Pilih Foto'),
                //           // content: Text('Pilih Foto'),
                //           actions: <Widget>[
                //             TextButton(
                //               child: Text('Kamera'),
                //               onPressed: () {
                //                 Navigator.pop(context);
                //                 // payController.pickImageKamera();
                //                 pickKamera();
                //                 // Navigator.pop(context);
                //               },
                //             ),
                //             TextButton(
                //               child: Text('Gallery'),
                //               onPressed: () {
                //                 pickGallery();
                //                 // payController.pickImageGallery();
                //                 Navigator.pop(context);
                //               },
                //             ),
                //           ],
                //         );
                //       }); },
                //       child: CircleAvatar(
                //         radius: 80,
                //         backgroundColor: Colors.grey,
                //         child: ClipOval( child: Image.network(widget.photoUser,
                //         width: 160,
                //             height: 160,
                //             fit: BoxFit.cover,
                //         ),),
                //       ),
                //     ):
                //     InkWell(
                //       onTap: () { showDialog(context: context, builder: (BuildContext context){
                //         return AlertDialog(
                //           title:  Text('Pilih Foto'),
                //           // content: Text('Pilih Foto'),
                //           actions: <Widget>[
                //             TextButton(
                //               child: Text('Kamera'),
                //               onPressed: () {
                //                 Navigator.pop(context);
                //                 // payController.pickImageKamera();
                //                 pickKamera();
                //                 // Navigator.pop(context);
                //               },
                //             ),
                //             TextButton(
                //               child: Text('Gallery'),
                //               onPressed: () {
                //                 pickGallery();
                //                 // payController.pickImageGallery();
                //                 Navigator.pop(context);
                //               },
                //             ),
                //           ],
                //         );
                //       }); },
                //       child: CircleAvatar(
                //         radius: 80,
                //         // backgroundImage: _image != null ? FileImage(_image!) : null,
                //         backgroundColor: Colors.grey,
                //         child: ClipOval(
                //           child: Image.file(
                //             _image!,
                //             width: 160,
                //             height: 160,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                
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
                  TextFormField(
                    controller: _nameController..text = widget.nama,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      // labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelStyle: TextStyle(
                        // color: Colors.blue,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    inputFormatters: [FilteringTextInputFormatter.deny(RegExp(''))],

                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                // textForm(_nameController..text = widget.nama,"Name",[FilteringTextInputFormatter.deny(RegExp(''))],TextInputType.text, 'Please enter your name','',false),
                if(widget.nama.isEmpty)
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      // labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
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
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                // textForm(_nameController,"Name",[FilteringTextInputFormatter.deny(RegExp(''))],TextInputType.text, 'Please enter your name','',false),
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
                if(widget.noHp.isNotEmpty)
                TextFormField(
                  controller: _phoneController..text = payController.respsonNohp.value,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    // labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelStyle: TextStyle(
                      // color: Colors.blue,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Phone';
                    }
                    return null;
                  },
                ),
                if(widget.noHp.isEmpty)
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      // labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelStyle: TextStyle(
                        // color: Colors.blue,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Phone';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) =>  Color(0xff37398B))
                  ),
                  onPressed: () {
                    var idpgn = payController.respsonIdPengguna.value;
                    updateUserProfile(idpgn.toString(), _nameController.text, _phoneController.text);    
                  },
                  child:
                  Obx(() =>
                  payController.isLoading.value ? CircularProgressIndicator():
                  Text('Simpan',style: TextStyle(color: Colors.white),),
                  ),
                  // Text('Create Account',style: TextStyle(
                  //   color: Colors.white
                  // ),),
                ),
                // ElevatedButton(onPressed: ()
                // {
                //   print(widget.photoUser);
                // }, style: ButtonStyle(
                //
                // ), child: Text('Update Profile',style: TextStyle(color: Color.fromARGB(255, 20, 123, 213)),),
                // ),
                SizedBox(height: 20),
                 
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> updateUserProfile(String userId, String name, String nohp) async {
  // final prefs = await SharedPreferences.getInstance();
  var token = await getToken();
  print(userId);
  print(token);
  // final token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('$BASE_URL/update-profile/$userId'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'name': name,
      'noHp': nohp,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Profile updated: ${data['user']}');
    if(data['success'] == true){
      final jsonResponse = data['user'];
      final Name = jsonResponse['name'];
      final nohpUser = jsonResponse['noHp'].toString();
      final sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.setString('NickUser', Name);
      sharedPreferences.setString('UserNohp', nohpUser);
      // payController.clearJsonDataTransaksi();
      // Get.offAllNamed(dashboard);
      Get.offAllNamed(dashboard);
      Get.snackbar(
        backgroundColor: Colors.blue,
        'Informasi', // Judul SnackBar
        'Profile berhasil di Update!', // Isi SnackBar
        snackPosition: SnackPosition.TOP, // Posisi SnackBar
        duration: Duration(seconds: 2), // Durasi tampilan SnackBar
        onTap: (snack) {
          // Aksi yang diambil ketika SnackBar ditekan
          print('SnackBar ditekan');
        },);
    }else{
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Warning",
        desc: '${data['message']}',
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

  } else {
    print('Failed to update profile: ${response.body}');
  }
}
}
