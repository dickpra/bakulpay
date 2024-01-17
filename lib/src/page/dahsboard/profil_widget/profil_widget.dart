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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Diganti menjadi MainAxisAlignment.spaceBetween
                  children: [
                    ///Poto Profil
                    Row(
                      children: [
                        CircleAvatar(radius: 40,
                        child: Obx(() => ClipOval(
                          child: Image.network(
                            width: 160,
                            height: 160,
                            payController.respsonphoto.value.toString(),
                            fit: BoxFit.cover,
                          ),
                        )),
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
                              Obx(() => Text(
                                payController.respsonNamaPgn.value,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      child: IconButton(
                        onPressed: () {
                          showAccessToken();
                        },
                        icon: Icon(Icons.edit_note),
                      ),
                    ),
                  ],
                ),
                ///Email Hp
                Padding(padding: EdgeInsets.all(23),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.call, color: Color(0xff7AA4F5),),
                          SizedBox(width: 15),
                          Obx(() => Text(
                            payController.respsonNohp.value,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          )),
                          // Text('Kosong 0897-9869-9786', style: TextStyle(
                          //   fontSize: 16, color: Colors.grey.shade600
                          // ),)
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.mail_outline, color: Color(0xff7AA4F5),),
                          SizedBox(width: 15),
                          Obx(() => Text(
                            payController.respsonEmail.value,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          )),
                          // Text('adhasjds@.acom', style: TextStyle(
                          //   fontSize: 16, color: Colors.grey.shade600
                          // ),)
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Divider()),
                  ],
                ),
                Padding(padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    TextButton(onPressed: (){}, child: Row(
                      children: [
                        Icon(Icons.help_outline, color: Color(0xff7AA4F5),size: 30,),
                        SizedBox(width: 10),
                        Text('FAQ (Frequently Asked Questions)', style: TextStyle(
                          fontSize: 16, color: Colors.black
                        ),)
                      ],
                    ),),
                    TextButton(onPressed: (){}, child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Color(0xff7AA4F5),size: 30,),
                        SizedBox(width: 10),
                        Text('About Me', style: TextStyle(
                            fontSize: 16, color: Colors.black
                        ),)
                      ],
                    ),),
                    TextButton(onPressed: (){}, child: Row(
                      children: [
                        Icon(Icons.contact_phone_outlined, color: Color(0xff7AA4F5),size: 30,),
                        SizedBox(width: 10),
                        Text('Hubungi Kami', style: TextStyle(
                            fontSize: 16, color: Colors.black
                        ),)
                      ],
                    ),),
                    TextButton(onPressed: (){
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
                                  // removeToken();
                                  removeUserFormLogin();
                                  // showAccessToken();
                                },
                              ),
                            ],
                          );
                        },
                      ) ?? false;
                    }, child: Row(
                      children: [
                        Icon(Icons.logout_outlined, color: Color(0xff7AA4F5),size: 30,),
                        SizedBox(width: 10),
                        Text('Logout', style: TextStyle(
                            fontSize: 16, color: Colors.black
                        ),)
                      ],
                    ),),
                  ],
                ),
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.all(20),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Container(
          //           decoration: BoxDecoration(
          //             // color: Colors.grey
          //           ),
          //           child: Padding(
          //             padding: EdgeInsets.all(0),
          //             child: Column(
          //               children: [
          //                 TextButton(
          //                   onPressed: (){},
          //                   child: Row(
          //                     children: [
          //                       Icon(Icons.quiz,
          //                       size:50),
          //                       SizedBox(width: 10),
          //                       Text('FAQ (Frequently Asked Questions)',style: TextStyle(
          //                         fontSize: 17,
          //                       ),)
          //                     ],
          //                   ),
          //                 ),
          //                 SizedBox(height: 10),
          //                 TextButton(
          //                   onPressed: (){},
          //                   child: Row(
          //                     children: [
          //                       Icon(Icons.info,
          //                           size:50),
          //                       SizedBox(width: 10),
          //                       Text('About me',style: TextStyle(
          //                         fontSize: 17,
          //                       ),)
          //                     ],
          //                   ),
          //                 ),
          //                 SizedBox(height: 10),
          //                 TextButton(
          //                   onPressed: (){},
          //                   child: Row(
          //                     children: [
          //                       Icon(Icons.contact_mail,
          //                           size:50),
          //                       SizedBox(width: 10),
          //                       Text('Hubungi kami',style: TextStyle(
          //                         fontSize: 17,
          //                       ),)
          //                     ],
          //                   ),
          //                 ),
          //                 SizedBox(height: 10),
          //                 TextButton(
          //                   onPressed: (){
          //                     showDialog<bool>(
          //                       context: context,
          //                       builder: (context) {
          //                         return AlertDialog(
          //                           title: Text('Konfirmasi'),
          //                           content: Text('Apakah Anda yakin ingin Logout dari aplikasi?'),
          //                           actions: <Widget>[
          //                             TextButton(
          //                               child: Text('Batal'),
          //                               onPressed: () {
          //                                 Navigator.of(context).pop(false);
          //                               },
          //                             ),
          //                             TextButton(
          //                               child: Text('Keluar'),
          //                               onPressed: () {
          //                                 Get.offAllNamed(root);
          //                                 // removeToken();
          //                                 removeUserFormLogin();
          //                                 // showAccessToken();
          //                               },
          //                             ),
          //                           ],
          //                         );
          //                       },
          //                     ) ?? false;
          //                   },
          //                   child: Row(
          //                     children: [
          //                       Icon(Icons.logout,
          //                           size:50,color: Colors.red,),
          //                       SizedBox(width: 10),
          //                       Text('Logout',style: TextStyle(
          //                         fontSize: 17,color: Colors.red
          //                       ),)
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
