import 'dart:io';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/payment_model.dart';
import 'package:bakulpay/src/page/topUp/bayar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';



class pembayaranPaypal extends StatefulWidget {final String email;
final int amount;

pembayaranPaypal({required this.email, required this.amount});


  @override
  _pembayaranPaypalState createState() => _pembayaranPaypalState();
}

class _pembayaranPaypalState extends State<pembayaranPaypal> {



  PayController payController = Get.put(PayController());
  int totalPayment = 0;
  String? selectedPaymentMethod;
  List<String> paymentMethods = ['Dana','OVO'];
  Map<String, String> paymentMethodIcons = {
    'Dana': 'assets/images/paypal.png',
    'OVO': 'assets/images/paypal.png',
    'GoPay': 'assets/gopay_icon.png',
  };
  String totalTagihan = '';


  File? _image;

  // int satuanHargaa = 16000;

  @override
  void initState() {
    super.initState();
    // payController.getDataRateTopup();
    // payController.getPayment();
    // Menghitung total pembayaran berdasarkan jumlah dollar dan satuan dollar
    // totalPayment = widget.amount * satuanHargaa;
  }

  @override
  Widget build(BuildContext context) {

    Container lissssss(RxList<payment_model> data, index) {
      final currencyFormat = NumberFormat.decimalPattern('en_US');
      return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.cyan,
          border: Border.all(),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Ikon
                Row(
                  children: [

                    CircleAvatar(
                      radius: 36,
                      child: Image.network('${data[index].icons}'),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),'${data[index].namaBank}'),
                        Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),'${data[index].noRekening}'),
                      ],
                    ),

                  ],
                ),
                /// Status
                Column(
                  children: [
                    // Container(
                    //   width: 100,
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     borderRadius:
                    //     BorderRadius.circular(10),
                    //     color: Colors.green,
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       '${data[index].produk}',
                    //       style: TextStyle(
                    //         fontSize: 13,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),'Rp.'),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    final _formKey = GlobalKey<FormState>();
    // Membuat instance NumberFormat
    final currencyFormat = NumberFormat.decimalPattern('en_US');
    TextEditingController namaPengirim = TextEditingController();

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

    return SafeArea(child: Scaffold(
        appBar: AppBar(
          title: Text('Total Pemesanan'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                    width: MediaQuery.sizeOf(context).width,
                    child: Image.asset('assets/images/paypal.png')
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey
                    ),
                    // color: Colors.red
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.blue
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.blue
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.list_alt,color: Colors.blue),
                                                SizedBox(width: 10),
                                                Text('Total Pesanan',style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.green
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Jenis Produk'),
                                                Text('Paypal',style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                ))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Email Paypal'),
                                                Text('${widget.email}',style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                )),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Jumlah'),
                                                Text('\$${widget.amount}',style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                )),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Harga Satuan'),
                                                // Text('Rp.${currencyFormat.format(satuanHargaa)}',style: TextStyle(
                                                //     fontWeight: FontWeight.bold
                                                // )),
                                                Obx(() {
                                                  var data = payController.jsonRate;
                                                  var bank = data['data'];
                                                  var topUpData = bank
                                                      .where((item) => item['nama_bank'] == 'Paypal')
                                                      .toList();
                                                  // print('daasdasdasdsa $data');
                                                  if (topUpData.isEmpty) {
                                                    return Center(
                                                        child: RefreshIndicator(
                                                            onRefresh: payController.getDataTransak,
                                                            child: const Text('Belum Ada Transaksi')));
                                                  } else {
                                                    return Column(
                                                      children: [
                                                        for (var item in topUpData)
                                                        // Text('${item['price']}')
                                                          Text('Rp.${currencyFormat.format(int.parse(item['price']))}',style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          )),
                                                      ],
                                                    );
                                                  }
                                                }),
                                              ],
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey
                    ),
                    // color: Colors.red
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(

                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    // color: Colors.blue
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.account_balance_wallet_rounded, color: Colors.blue,),
                                                    SizedBox(width: 10),
                                                    Text('Total Pembayaran'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),

                                        /// Total Pembayaran

                                        Container(
                                            decoration: BoxDecoration(
                                                // color: Colors.green
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Subtotal Tagihan'),
                                                    // Text('Rp.${currencyFormat.format(totalPayment)}',style: TextStyle(
                                                    //     fontWeight: FontWeight.bold
                                                    // )),
                                                    Obx(() {
                                                      var data = payController.jsonRate;
                                                      var bank = data['data'];
                                                      var topUpData = bank
                                                          .where((item) => item['nama_bank'] == 'Paypal')
                                                          .toList();
                                                      // print('daasdasdasdsa $data');
                                                      if (topUpData.isEmpty) {
                                                        return Center(
                                                            child: RefreshIndicator(
                                                                onRefresh: payController.getDataRateTopup,
                                                                child: const Text('Belum Ada Transaksi')));
                                                      } else {
                                                        return Column(
                                                          children: [
                                                            for (var item in topUpData)
                                                            // Text('${item['price']}')
                                                              Text('Rp.${currencyFormat.format(int.parse(item['price']) * widget.amount)}',style: TextStyle(
                                                                  fontWeight: FontWeight.bold
                                                              )),
                                                          ],
                                                        );
                                                      }
                                                    }),
                                                  ],
                                                ),
                                                // Obx(() {
                                                //   var data = payController.jsonRate;
                                                //   var bank = data['data'];
                                                //   var topUpData = bank
                                                //   .where((item) => item['nama_bank'] == 'Paypal')
                                                //       .toList();
                                                //   // print('daasdasdasdsa $data');
                                                //   if (topUpData.isEmpty) {
                                                //     return Center(
                                                //         child: RefreshIndicator(
                                                //             onRefresh: payController.getDataTransak,
                                                //             child: const Text('Belum Ada Transaksi')));
                                                //   } else {
                                                //     return Column(
                                                //       children: [
                                                //         for (var item in topUpData)
                                                //           // Text('${item['price']}')
                                                //         Text('Rp.${currencyFormat.format(int.parse(item['price']))}',style: TextStyle(
                                                //             fontWeight: FontWeight.bold
                                                //         )),
                                                //       ],
                                                //     );
                                                //   }
                                                // }),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Biaya Transaksi'),
                                                    Text('Rp.0,00',style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                    )),
                                                  ],
                                                ),
                                              ],
                                            )
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
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
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      // BoxShadow(
                      //   color: Colors.grey.withOpacity(0.5), // Warna bayangan
                      //   spreadRadius: 2, // Seberapa luas bayangan menyebar
                      //   blurRadius: 5, // Seberapa kabur bayangan
                      //   offset: Offset(0, 3), // Perpindahan bayangan secara horizontal dan vertikal
                      // ),
                    ],
                    border: Border.all(
                        color: Colors.grey
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.blue
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Tagihan Pembayaran',style: TextStyle(
                                  fontSize: 16,
                                    fontWeight: FontWeight.bold
                                )),

                                /// Rate PayPal API
                                Obx(() {
                                  final data = payController.jsonRate;
                                  final bank = data['data'];
                                  final topUpData = bank
                                      .where((item) => item['nama_bank'] == 'Paypal')
                                      .where((item) => item['type'] == 'Top Up')
                                      .toList();
                                  // print('daasdasdasdsa $data');
                                  if (topUpData.isEmpty) {
                                    return Center(
                                      child: RefreshIndicator(
                                        onRefresh: payController.getDataRateTopup,
                                        child: Text('Belum Ada Transaksi'),
                                      ),
                                    );
                                  } else {
                                    for  (var item in topUpData) {
                                      totalTagihan = 'Rp.${currencyFormat.format(int.parse(item['price'].toString()) * widget.amount)}';
                                    }
                                    return Column(
                                      children: [
                                        // for (var item in topUpData)
                                        // Text('${item['price']}')
                                          Text(
                                            totalTagihan,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                      ],
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // DropdownButtonFormField<String>(
                      //   hint: Text('Pilih Metode Pencairan'),
                      //   value: selectedPaymentMethod,
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       selectedPaymentMethod = newValue!;
                      //     });
                      //   },
                      //   items: paymentMethods.map<DropdownMenuItem<String>>(
                      //         (String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Row(
                      //           children: [
                      //             Image.asset(
                      //               paymentMethodIcons[value]!,
                      //               height: 30,
                      //               width: 30,
                      //             ),
                      //             SizedBox(width: 10),
                      //             Text(value),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ).toList(),
                      // ),
                      // TextButton(onPressed: (){
                      //   var data = selectedPaymentMethod;
                      //   print(data);
                      // },
                      //     child: Text('peleer')),
                      Obx(() {
                          final data = payController.jsonPembayaran;
                          // print('daasdasdasdsa $data');
                          if (data.isEmpty) {
                            return Center(
                              child:  Text('Belum Ada Metode Pembayaran'),
                            );
                          } else {
                            return DropdownButtonFormField<String>(
                              hint: const Text('Pilih Metode Pencairan'),
                              value: selectedPaymentMethod, // Gunakan selectedPaymentMethod dari payController
                              onChanged: (newValue) {
                                selectedPaymentMethod = newValue;
                              },
                              items: payController.jsonPembayaran.map<DropdownMenuItem<String>>(
                                    (paymentModel) {
                                  // Jika paymentModel memiliki property 'name', ganti dengan properti yang sesuai
                                  String value = paymentModel.namaBank.toString();

                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      children: [
                                        // Sesuaikan dengan struktur objek model Anda
                                        Image.network(
                                          paymentModel.icons,
                                          height: 30,
                                          width: 30,
                                        ),
                                        SizedBox(width: 10),
                                        Text(value),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          }
                        },
                      )

                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Obx(() {
                //   if(payController.selectedPaymentMethod.isNotEmpty){
                //     return Row(
                //       children: [
                //         Expanded(
                //           child: Padding(
                //             padding:  EdgeInsets.all(16),
                //             child: Container(
                //               child: Column(
                //                 children: [
                //                   Align(
                //                     alignment: Alignment.topLeft,
                //                     child: Padding(
                //                       padding:  EdgeInsets.all(5),
                //                       child: Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),'Silahkan Transfer ke'),
                //                     ),
                //                   ),
                //                   Align(
                //                     alignment: Alignment.center,
                //                     child: Padding(
                //                       padding: EdgeInsets.all(5),
                //                       child: Text(style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),selectedPaymentMethod.toString()),
                //                     ),
                //                   ),
                //
                //                   if(selectedPaymentMethod!.contains('Dana'))
                //                     Container(
                //                         decoration: BoxDecoration(
                //                           // color: Colors.green
                //                         ),
                //                         child: Column(
                //                           children: [
                //                             Row(
                //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 Text('Nomor Dana'),
                //                                 Row(
                //                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                                   children: [
                //                                     IconButton(
                //                                       iconSize: 15,
                //                                       color: Colors.blue,
                //                                       onPressed: () {
                //                                         Clipboard.setData(ClipboardData(text: '087212223993'));
                //
                //                                       },
                //                                       icon: Icon(Icons.copy),
                //                                     ),
                //                                     Text(
                //                                       '087212223993',
                //                                       style: TextStyle(
                //                                         fontWeight:
                //                                         FontWeight.bold,
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ],
                //                             ),
                //                             Row(
                //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 Text('Atas Nama'),
                //                                 Text('Jong Java',style: TextStyle(
                //                                     fontWeight: FontWeight.bold
                //                                 )),
                //                               ],
                //                             ),
                //                             SizedBox(height: 20),
                //                             Container(
                //                               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //                               decoration: BoxDecoration(
                //                                   borderRadius: BorderRadius.circular(15),
                //                                   color: Color(0x3879a3f5)),
                //                               child: Column(
                //                                 children: [
                //                                   Text('Transfer total pembayaran sesuai dengan rincian diatas ke nomor rekening atas nama Jong Java.'),
                //                                   SizedBox(height: 10),
                //                                   Text('Biaya transaksi ditanggung pengguna,Lalu upload bukti transfer pada kolom yang disediakan dibawah ini.'),
                //                                 ],
                //                               ),
                //                             ),
                //                             SizedBox(height: 20),
                //                             Align(
                //                               alignment: Alignment.topLeft,
                //                               child: Padding(
                //                                 padding: const EdgeInsets.all(5),
                //                                 child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Upload Bukti Pembayaran'),
                //                               ),
                //                             ),
                //                             SizedBox(height: 20),
                //                             InkWell(
                //                               onTap: () {
                //                                 showDialog(context: context, builder: (BuildContext context){
                //                                   return AlertDialog(
                //                                     title: const Text('Pilih Bukti Pembayaran'),
                //                                     // content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                //                                     actions: <Widget>[
                //                                       TextButton(
                //                                         child: Text('Kamera'),
                //                                         onPressed: () {
                //                                           pickKamera();
                //                                           // Navigator.pop(context);
                //                                         },
                //                                       ),
                //                                       TextButton(
                //                                         child: Text('Gallery'),
                //                                         onPressed: () {
                //                                           pickGallery();
                //                                           Navigator.pop(context);
                //                                         },
                //                                       ),
                //                                     ],
                //                                   );
                //                                 });
                //                                 // if(_image != null){
                //                                 //   Navigator.push(
                //                                 //     context,
                //                                 //     MaterialPageRoute(
                //                                 //       builder: (context) => FullScreenImage(imageFile: _image),
                //                                 //     ),
                //                                 //   );
                //                                 // }
                //                               },
                //                               child: _image == null
                //                                   ? Container(
                //                                 padding: EdgeInsets.all(5),
                //                                 child: Column(
                //                                   children: [
                //                                     Icon(
                //                                       Icons.add,
                //                                       color: Colors.grey[800],
                //                                       size: 50.0,
                //                                     ),
                //                                     Text('Pilih bukti Pembayaran')
                //                                   ],
                //                                 ),
                //                               )
                //                                   : Image.file(
                //                                 _image!,
                //                                 width: 150,
                //                                 height: 150,
                //                                 fit: BoxFit.cover,
                //                               ),
                //                             ),
                //                             if(_image != null)
                //                               TextButton(onPressed: (){
                //                                 Navigator.push(
                //                                   context,
                //                                   MaterialPageRoute(
                //                                     builder: (context) => FullScreenImage(imageFile: _image),
                //                                   ),
                //                                 );
                //                               }, child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Lihat Bukti')),
                //                             SizedBox(height: 20),
                //                             Align(
                //                               alignment: Alignment.topLeft,
                //                               child: Padding(
                //                                 padding: const EdgeInsets.all(5),
                //                                 child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Nama Pengirim Dana'),
                //                               ),
                //                             ),
                //                             Form(key: _formKey,child: textForm(namaPengirim, 'Masukkan Nama Pengirim', [FilteringTextInputFormatter.deny(RegExp(' '))], TextInputType.text, 'Masukkan Nama Pengirim', '', false)),
                //
                //                           ],
                //                         )
                //                     ),
                //                   if(selectedPaymentMethod!.contains('Gopay'))
                //                     Container(
                //                         decoration: BoxDecoration(
                //                           // color: Colors.green
                //                         ),
                //                         child: Column(
                //                           children: [
                //                             Row(
                //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 Text('Nomor OVO'),
                //                                 Row(
                //                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                                   children: [
                //                                     IconButton(
                //                                       iconSize: 15,
                //                                       color: Colors.blue,
                //                                       onPressed: () {
                //                                         Clipboard.setData(ClipboardData(text: '087212223993'));
                //                                         // ScaffoldMessenger.of(context).showSnackBar(
                //                                         //   SnackBar(content: Text('Nomor HP disalin'),
                //                                         //   ),
                //                                         // );
                //                                       },
                //                                       icon: Icon(Icons.copy),
                //                                     ),
                //                                     Text(
                //                                       '087212223993',
                //                                       style: TextStyle(
                //                                         fontWeight:
                //                                         FontWeight.bold,
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ],
                //                             ),
                //                             Row(
                //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 Text('Atas Nama'),
                //                                 Text('Jong Java',style: TextStyle(
                //                                     fontWeight: FontWeight.bold
                //                                 )),
                //                               ],
                //                             ),
                //                             SizedBox(height: 20),
                //                             Container(
                //                               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //                               decoration: BoxDecoration(
                //                                   borderRadius: BorderRadius.circular(15),
                //                                   color: Color(0x3879a3f5)),
                //                               child: Column(
                //                                 children: [
                //                                   Text('Transfer total pembayaran sesuai dengan rincian diatas ke nomor rekening atas nama Jong Java.'),
                //                                   SizedBox(height: 10),
                //                                   Text('Biaya transaksi ditanggung pengguna,Lalu upload bukti transfer pada kolom yang disediakan dibawah ini.'),
                //                                 ],
                //                               ),
                //                             ),
                //                             Align(
                //                               alignment: Alignment.topLeft,
                //                               child: Padding(
                //                                 padding: const EdgeInsets.all(5),
                //                                 child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Upload Bukti Pembayaran'),
                //                               ),
                //                             ),
                //                             SizedBox(height: 20),
                //                             InkWell(
                //                               onTap: () {
                //                                 showDialog(context: context, builder: (BuildContext context){
                //                                   return AlertDialog(
                //                                     title: const Text('Pilih Bukti Pembayaran'),
                //                                     // content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                //                                     actions: <Widget>[
                //                                       TextButton(
                //                                         child: Text('Kamera'),
                //                                         onPressed: () {
                //                                           pickKamera();
                //                                           // Navigator.pop(context);
                //                                         },
                //                                       ),
                //                                       TextButton(
                //                                         child: Text('Gallery'),
                //                                         onPressed: () {
                //                                           pickGallery();
                //                                           Navigator.pop(context);
                //                                         },
                //                                       ),
                //                                     ],
                //                                   );
                //                                 });
                //                                 // if(_image != null){
                //                                 //   Navigator.push(
                //                                 //     context,
                //                                 //     MaterialPageRoute(
                //                                 //       builder: (context) => FullScreenImage(imageFile: _image),
                //                                 //     ),
                //                                 //   );
                //                                 // }
                //                               },
                //                               child: _image == null
                //                                   ? Container(
                //                                 padding: EdgeInsets.all(5),
                //                                 child: Column(
                //                                   children: [
                //                                     Icon(
                //                                       Icons.add,
                //                                       color: Colors.grey[800],
                //                                       size: 50.0,
                //                                     ),
                //                                     Text('Pilih bukti Pembayaran')
                //                                   ],
                //                                 ),
                //                               )
                //                                   : Image.file(
                //                                 _image!,
                //                                 width: 150,
                //                                 height: 150,
                //                                 fit: BoxFit.cover,
                //                               ),
                //                             ),
                //                             if(_image != null)
                //                               TextButton(onPressed: (){
                //                                 Navigator.push(
                //                                   context,
                //                                   MaterialPageRoute(
                //                                     builder: (context) => FullScreenImage(imageFile: _image),
                //                                   ),
                //                                 );
                //                               }, child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Lihat Bukti')),
                //                             SizedBox(height: 20),
                //                             Align(
                //                               alignment: Alignment.topLeft,
                //                               child: Padding(
                //                                 padding: const EdgeInsets.all(5),
                //                                 child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Nama Pengirim OVO'),
                //                               ),
                //                             ),
                //                             Form(key: _formKey,child: textForm(namaPengirim, 'Masukkan Nama Pengirim', [FilteringTextInputFormatter.deny(RegExp(' '))], TextInputType.text, 'Masukkan Nama Pengirim', '', false)),
                //
                //                           ],
                //                         )
                //                     ),
                //                   if(selectedPaymentMethod!=null)
                //                     Align(
                //                       alignment: Alignment.bottomCenter,
                //                       child: ElevatedButton(
                //                         onPressed: () {
                //                           print(widget.email);
                //                           print(widget.amount);
                //                           print(totalPayment);
                //                           print(selectedPaymentMethod.toString());
                //                           print(selectedPaymentMethod.toString());
                //                           print(_image);
                //
                //                           // Lakukan sesuatu dengan informasi yang telah terkumpul
                //                           // Misalnya, kirim data ke server atau lakukan transaksi pembayaran
                //                           // ...
                //
                //                           // Tampilkan pesan konfirmasi atau navigasi ke halaman lain jika diperlukan
                //                           // ScaffoldMessenger.of(context).showSnackBar(
                //                           //   SnackBar(
                //                           //     content: Text('Pemesanan berhasil!'),
                //                           //   ),
                //                           // );
                //                           //
                //                           // // Contoh navigasi ke halaman lain setelah pemesanan berhasil
                //                           // Navigator.pushReplacementNamed(context, '/home');
                //                         },
                //                         child: Text('Bayar'),
                //                       ),
                //                     ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     );
                //   }else{
                //     return Container();
                //   }
                // }),
                if(selectedPaymentMethod != null)
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.all(16),
                        child: Container(
                          child: Column(
                            children: [
                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: Padding(
                              //     padding:  EdgeInsets.all(5),
                              //     child: Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),'Silahkan Transfer ke'),
                              //   ),
                              // ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),selectedPaymentMethod.toString()),
                                ),
                              ),

                              if(selectedPaymentMethod!.contains('Dana'))
                                Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.green
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Nomor Dana'),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                iconSize: 15,
                                                color: Colors.blue,
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: '087212223993'));

                                                },
                                                icon: Icon(Icons.copy),
                                              ),
                                              Text(
                                                '087212223993',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Atas Nama'),
                                          Text('Jong Java',style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          )),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Color(0x3879a3f5)),
                                        child: Column(
                                          children: [
                                            Text('Transfer total pembayaran sesuai dengan rincian diatas ke nomor rekening atas nama Jong Java.'),
                                            SizedBox(height: 10),
                                            Text('Biaya transaksi ditanggung pengguna,Lalu upload bukti transfer pada kolom yang disediakan dibawah ini.'),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Upload Bukti Pembayaran'),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      InkWell(
                                        onTap: () {
                                          showDialog(context: context, builder: (BuildContext context){
                                            return AlertDialog(
                                              title: const Text('Pilih Bukti Pembayaran'),
                                              // content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Kamera'),
                                                  onPressed: () {
                                                    pickKamera();
                                                    // Navigator.pop(context);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Gallery'),
                                                  onPressed: () {
                                                    pickGallery();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                          // if(_image != null){
                                          //   Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) => FullScreenImage(imageFile: _image),
                                          //     ),
                                          //   );
                                          // }
                                        },
                                        child: _image == null
                                            ? Container(
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: Colors.grey[800],
                                                size: 50.0,
                                              ),
                                              Text('Pilih bukti Pembayaran')
                                            ],
                                          ),
                                        )
                                            : Image.file(
                                          _image!,
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if(_image != null)
                                        TextButton(onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FullScreenImage(imageFile: _image),
                                            ),
                                          );
                                        }, child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Lihat Bukti')),
                                      SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Nama Pengirim Dana'),
                                        ),
                                      ),
                                      Form(key: _formKey,child: textForm(namaPengirim, 'Masukkan Nama Pengirim', [FilteringTextInputFormatter.deny(RegExp(' '))], TextInputType.text, 'Masukkan Nama Pengirim', '', false)),

                                    ],
                                  )
                              ),
                              if(selectedPaymentMethod!.contains('Gopay'))
                                Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.green
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Nomor OVO'),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  IconButton(
                                                    iconSize: 15,
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      Clipboard.setData(ClipboardData(text: '087212223993'));
                                                      // ScaffoldMessenger.of(context).showSnackBar(
                                                      //   SnackBar(content: Text('Nomor HP disalin'),
                                                      //   ),
                                                      // );
                                                    },
                                                    icon: Icon(Icons.copy),
                                                  ),
                                                  Text(
                                                    '087212223993',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Atas Nama'),
                                            Text('Jong Java',style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            )),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Color(0x3879a3f5)),
                                          child: Column(
                                            children: [
                                              Text('Transfer total pembayaran sesuai dengan rincian diatas ke nomor rekening atas nama Jong Java.'),
                                              SizedBox(height: 10),
                                              Text('Biaya transaksi ditanggung pengguna,Lalu upload bukti transfer pada kolom yang disediakan dibawah ini.'),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Upload Bukti Pembayaran'),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        InkWell(
                                          onTap: () {
                                            showDialog(context: context, builder: (BuildContext context){
                                              return AlertDialog(
                                                title: const Text('Pilih Bukti Pembayaran'),
                                                // content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Kamera'),
                                                    onPressed: () {
                                                      pickKamera();
                                                      // Navigator.pop(context);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Gallery'),
                                                    onPressed: () {
                                                      pickGallery();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                            // if(_image != null){
                                            //   Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) => FullScreenImage(imageFile: _image),
                                            //     ),
                                            //   );
                                            // }
                                          },
                                          child: _image == null
                                              ? Container(
                                            padding: EdgeInsets.all(5),
                                                child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.grey[800],
                                                        size: 50.0,
                                                      ),
                                                      Text('Pilih bukti Pembayaran')
                                                    ],
                                                  ),
                                              )
                                              : Image.file(
                                                  _image!,
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                          ),
                                        if(_image != null)
                                          TextButton(onPressed: (){
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => FullScreenImage(imageFile: _image),
                                                    ),
                                                  );
                                          }, child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Lihat Bukti')),
                                        SizedBox(height: 20),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Nama Pengirim OVO'),
                                          ),
                                        ),
                                        Form(key: _formKey,child: textForm(namaPengirim, 'Masukkan Nama Pengirim', [FilteringTextInputFormatter.deny(RegExp(' '))], TextInputType.text, 'Masukkan Nama Pengirim', '', false)),

                                      ],
                                    )
                                ),
                              if(selectedPaymentMethod!=null)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print(widget.email);
                                    print(widget.amount);
                                    print(totalPayment);
                                    print(selectedPaymentMethod.toString());
                                    print(_image);

                                    // Lakukan sesuatu dengan informasi yang telah terkumpul
                                    // Misalnya, kirim data ke server atau lakukan transaksi pembayaran
                                    // ...

                                    // Tampilkan pesan konfirmasi atau navigasi ke halaman lain jika diperlukan
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text('Pemesanan berhasil!'),
                                    //   ),
                                    // );
                                    //
                                    // // Contoh navigasi ke halaman lain setelah pemesanan berhasil
                                    // Navigator.pushReplacementNamed(context, '/home');
                                  },
                                  child: Text('Bayar'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {

                      print(widget.email);
                      print(widget.amount);
                      print(totalTagihan);
                      print(selectedPaymentMethod.toString());
                      print(_image);
                      confirmPayment(context);
                    },
                    child: Text('Bayar'),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //
                //     print(widget.email);
                //     print(widget.amount);
                //     print(totalTagihan);
                //     print(selectedPaymentMethod.toString());
                //     print(_image);
                //     confirmPayment(context);
                //   },
                //   child: Text('Bayar'),
                // ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  void confirmPayment(context){
    Navigator.push(
        context,
    MaterialPageRoute(
      builder: (context) => BuatPesanan(
        email: widget.email.toString(),
        jumlah: widget.amount.toString(),
        total_pembayaran: totalTagihan.toString(),
        kode_bank_client: widget.email.toString(),
        nama_bank: selectedPaymentMethod.toString(),
      ),
    )
    );
  }

}

class FullScreenImage extends StatelessWidget {
  final File? imageFile;

  FullScreenImage({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'fullScreenImage',
            child: Image.file(
              imageFile!,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class pembayaranPerfectM extends StatefulWidget {final String email;
final int amount;

pembayaranPerfectM({required this.email, required this.amount});


@override
_pembayaranPerfectMState createState() => _pembayaranPerfectMState();
}

class _pembayaranPerfectMState extends State<pembayaranPerfectM> {



  PayController payController = Get.put(PayController());
  int totalPayment = 0;
  String? selectedPaymentMethod;

  String totalTagihan = '';


  File? _image;

  // int satuanHargaa = 16000;

  @override
  void initState() {
    super.initState();
    // payController.getDataRateTopup();
    // payController.getPayment();
    // Menghitung total pembayaran berdasarkan jumlah dollar dan satuan dollar
    // totalPayment = widget.amount * satuanHargaa;
  }

  @override
  Widget build(BuildContext context) {

    final currencyFormat = NumberFormat.decimalPattern('en_US');

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Total Pemesanan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 120,
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.asset('assets/images/perfectmoney.png')
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey
                  ),
                  // color: Colors.red
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.blue
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.blue
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.list_alt,color: Colors.blue),
                                              SizedBox(width: 10),
                                              Text('Total Pesanan',style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.green
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Jenis Produk'),
                                              Text('PerfectMoney',style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('uid PerfectMoney'),
                                              Text('${widget.email}',style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              )),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Jumlah'),
                                              Text('\$${widget.amount}',style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              )),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Harga Satuan'),
                                              // Text('Rp.${currencyFormat.format(satuanHargaa)}',style: TextStyle(
                                              //     fontWeight: FontWeight.bold
                                              // )),
                                              Obx(() {
                                                var data = payController.jsonRate;
                                                var bank = data['data'];
                                                var topUpData = bank
                                                    .where((item) => item['nama_bank'] == 'Perfect Money')
                                                    .toList();
                                                // print('daasdasdasdsa $data');
                                                if (topUpData.isEmpty) {
                                                  return Center(
                                                      child: RefreshIndicator(
                                                          onRefresh: payController.getDataTransak,
                                                          child: const Text('Belum Ada Transaksi')));
                                                } else {
                                                  return Column(
                                                    children: [
                                                      for (var item in topUpData)
                                                      // Text('${item['price']}')
                                                        Text('Rp.${currencyFormat.format(int.parse(item['price']))}',style: TextStyle(
                                                            fontWeight: FontWeight.bold
                                                        )),
                                                    ],
                                                  );
                                                }
                                              }),
                                            ],
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey
                  ),
                  // color: Colors.red
                ),
                padding: EdgeInsets.symmetric(vertical: 1),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(

                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                // color: Colors.blue
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.account_balance_wallet_rounded, color: Colors.blue,),
                                                  SizedBox(width: 10),
                                                  Text('Total Pembayaran'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),

                                      /// Total Pembayaran

                                      Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.green
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Subtotal Tagihan'),
                                                  // Text('Rp.${currencyFormat.format(totalPayment)}',style: TextStyle(
                                                  //     fontWeight: FontWeight.bold
                                                  // )),
                                                  Obx(() {
                                                    var data = payController.jsonRate;
                                                    var bank = data['data'];
                                                    var topUpData = bank
                                                        .where((item) => item['nama_bank'] == 'Perfect Money')
                                                        .toList();
                                                    // print('daasdasdasdsa $data');
                                                    if (topUpData.isEmpty) {
                                                      return Center(
                                                          child: RefreshIndicator(
                                                              onRefresh: payController.getDataRateTopup,
                                                              child: const Text('Belum Ada Transaksi')));
                                                    } else {
                                                      return Column(
                                                        children: [
                                                          for (var item in topUpData)
                                                          // Text('${item['price']}')
                                                            Text('Rp.${currencyFormat.format(int.parse(item['price']) * widget.amount)}',style: TextStyle(
                                                                fontWeight: FontWeight.bold
                                                            )),
                                                        ],
                                                      );
                                                    }
                                                  }),
                                                ],
                                              ),
                                              
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Biaya Transaksi'),
                                                  Text('Rp.0,00',style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  )),
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
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
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    // BoxShadow(
                    //   color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    //   spreadRadius: 2, // Seberapa luas bayangan menyebar
                    //   blurRadius: 5, // Seberapa kabur bayangan
                    //   offset: Offset(0, 3), // Perpindahan bayangan secara horizontal dan vertikal
                    // ),
                  ],
                  border: Border.all(
                      color: Colors.grey
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.blue
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Tagihan Pembayaran',style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              )),

                              /// Rate PayPal API
                              Obx(() {
                                final data = payController.jsonRate;
                                final bank = data['data'];
                                final topUpData = bank
                                    .where((item) => item['nama_bank'] == 'Perfect Money')
                                    .where((item) => item['type'] == 'Top Up')
                                    .toList();
                                // print('daasdasdasdsa $data');
                                if (topUpData.isEmpty) {
                                  return Center(
                                    child: RefreshIndicator(
                                      onRefresh: payController.getDataRateTopup,
                                      child: Text('Belum Ada Transaksi'),
                                    ),
                                  );
                                } else {
                                  for  (var item in topUpData) {
                                    totalTagihan = 'Rp.${currencyFormat.format(int.parse(item['price'].toString()) * widget.amount)}';
                                  }
                                  return Column(
                                    children: [
                                      // for (var item in topUpData)
                                      // Text('${item['price']}')
                                      Text(
                                        totalTagihan,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [

                    ///dropList Api pilih Bank
                    Obx(() {
                      final data = payController.jsonPembayaran;
                      // print('daasdasdasdsa $data');
                      if (data.isEmpty) {
                        return Center(
                          child:  Text('Belum Ada Metode Pembayaran'),
                        );
                      } else {
                        return DropdownButtonFormField<String>(
                          hint: const Text('Pilih Metode Pencairan'),
                          value: selectedPaymentMethod, // Gunakan selectedPaymentMethod dari payController
                          onChanged: (newValue) {
                            selectedPaymentMethod = newValue;
                          },
                          items: payController.jsonPembayaran.map<DropdownMenuItem<String>>(
                                (paymentModel) {
                              // Jika paymentModel memiliki property 'name', ganti dengan properti yang sesuai
                              String value = paymentModel.namaBank.toString();

                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    // Sesuaikan dengan struktur objek model Anda
                                    Image.network(
                                      paymentModel.icons,
                                      height: 30,
                                      width: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Text(value),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        );
                      }
                    },
                    )

                  ],
                ),
              ),
              SizedBox(height: 20),

              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {

                    print(widget.email);
                    print(widget.amount);
                    print(totalTagihan);
                    print(selectedPaymentMethod.toString());
                    print(_image);
                    // confirmPayment(context);
                    if(selectedPaymentMethod != null){
                      kirimData();
                    }else{
                      showDialog(context: context,builder: (context) {
                        return AlertDialog(
                          title: Center(child: Text('Bank Harus Dipilih')),
                          // content: Text('Bank Harus Dipilih'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('ok'),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },);
                    }
                  },

                  child:
                  Obx(() => payController.isLoading.value ? CircularProgressIndicator():
                  Text('Bayar'),
                ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    var data = payController.responPembayaran;
                    print(data);

                  },
                  child: Text('Tes'),
                ),
              ),
              
            ],
          ),
        ),
      ),
    ),
    );
  }

  void confirmPayment(context){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BuatPesanan(
            email: widget.email.toString(),
            jumlah: widget.amount.toString(),
            total_pembayaran: totalTagihan.toString(),
            kode_bank_client: widget.email.toString(),
            nama_bank: selectedPaymentMethod.toString(),
          ),
        )
    );
  }

  void kirimData(){
      Map<String, dynamic> data = {
        "user_id": "50",
        "jumlah": widget.amount,
        "total_pembayaran": totalTagihan,
        "nama_bank": selectedPaymentMethod,
        "rek_client": widget.email
      };

      // Mengirim data ke API
      print('$data');
      payController.KirimTopup(data);

    }


}


