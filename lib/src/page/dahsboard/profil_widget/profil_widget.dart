import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/router/constant.dart';
import 'package:bakulpay/src/service/preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class profilWidget extends StatefulWidget {
  const profilWidget({super.key});

  @override
  State<profilWidget> createState() => _profilWidgetState();
}

class _profilWidgetState extends State<profilWidget> {
  PayController payController = Get.put(PayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Diganti menjadi MainAxisAlignment.spaceBetween
              children: [
                Container(
            
                    child: Row(
                      children: [
                        CircleAvatar(radius: 30,
                        child: Icon(Icons.person),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                          ),
                          // alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat Datang,',
                                style: TextStyle(fontSize: 12, color: Colors.grey), // Tambahkan warna teks
                              ),
                              Obx(() => Text(
                                payController.respsonNamaPgn.value,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Align(
                  child: IconButton(
                    onPressed: () {  },
                    icon: Icon(Icons.edit_note),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: (){},
                            child: Row(
                              children: [
                                Icon(Icons.quiz,
                                size:50),
                                SizedBox(width: 10),
                                Text('FAQ (Frequently Asked Questions)',style: TextStyle(
                                  fontSize: 17,
                                ),)
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: (){},
                            child: Row(
                              children: [
                                Icon(Icons.info,
                                    size:50),
                                SizedBox(width: 10),
                                Text('About me',style: TextStyle(
                                  fontSize: 17,
                                ),)
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: (){},
                            child: Row(
                              children: [
                                Icon(Icons.contact_mail,
                                    size:50),
                                SizedBox(width: 10),
                                Text('Hubungi kami',style: TextStyle(
                                  fontSize: 17,
                                ),)
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: (){
                              showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Konfirmasi'),
                                    content: Text('Apakah Anda yakin ingin Logout dari aplikasi?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Batal'),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Keluar'),
                                        onPressed: () {
                                          Get.offAllNamed(root);
                                          removeToken();
                                          // showAccessToken();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ) ?? false;
                            },
                            child: Row(
                              children: [
                                Icon(Icons.logout,
                                    size:50,color: Colors.red,),
                                SizedBox(width: 10),
                                Text('Logout',style: TextStyle(
                                  fontSize: 17,color: Colors.red
                                ),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
