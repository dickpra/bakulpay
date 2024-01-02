import 'dart:io';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/model_topup.dart';
import 'package:bakulpay/src/model/pembayaran_model.dart';
import 'package:bakulpay/src/page/dahsboard/dashboard.dart';
import 'package:bakulpay/src/setting/env.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/pembayaran_wd.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class BuatPesananWd extends StatefulWidget {
  final model_topup data;



  BuatPesananWd({required this.data});

  @override
  State<BuatPesananWd> createState() => _BuatPesananWdState();
}

class _BuatPesananWdState extends State<BuatPesananWd> {

  PayController payController = Get.put(PayController());
  File? _image;
  final _formKey = GlobalKey<FormState>();
  // Membuat instance NumberFormat
  final currencyFormat = NumberFormat.decimalPattern('en_US');
  TextEditingController namaPengirim = TextEditingController();
  String kodebank = '';
  String namaRekBank = '';
  String iconBank = '';



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
  void initState() {
    super.initState();
    // payController.getDataRateTopup();
    // payController.getPayment();
    // Menghitung total pembayaran berdasarkan jumlah dollar dan satuan dollar
    // totalPayment = widget.amount * satuanHargaa;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Pembayaran', style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold
          )),
          centerTitle: true,
        ),
        body: WillPopScope(child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    //   border: Border.all(
                    //       color: Colors.grey
                    //   )
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            children: [
                              // if(widget.data.product.toString().contains('Skrill'))
                              //   Image.asset('assets/images/skrill.png',scale: 5,),
                              // if(widget.data.product.toString().contains('Perfect Money'))
                              //   Image.asset('assets/images/perfectmoney.png',scale: 10,),
                              Obx(() {
                                final data = payController.jsonWithdraw;
                                // final bank = data;
                                // print(data);

                                final topUpData = data
                                    .where((item) => item.namaBank == widget.data.product)
                                    .toList();

                                if (topUpData.isEmpty) {
                                  return Center(
                                      child: const Text('Belum Ada Transaksi'));
                                } else {
                                  for (var item in topUpData){
                                    iconBank = item.icons;

                                  }
                                  return Center(child: Image.network(iconBank,scale: 0.3,));
                                }
                              }),
                              SizedBox(height: 10),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                      border: Border.all(
                          color: Colors.grey
                      )
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                              'Total Pembayaran',
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                              '\$${widget.data.totalPembayaran}',
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.green
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),'Silahkan Transfer ke'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rekening ${widget.data.product}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  iconSize: 15,
                                  color: Colors.blue,
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: kodebank));

                                  },
                                  icon: Icon(Icons.copy),
                                ),
                                Obx(() {
                                  final data = payController.jsonWithdraw;
                                  // final bank = data;
                                  // print(data);

                                  final topUpData = data
                                      .where((item) => item.namaBank == widget.data.namaBank)
                                      .toList();
                                  // print('meki $topUpData');
                                  // print('dasdasdsa $data');
                                  if (topUpData.isEmpty) {
                                    return Center(
                                      child: RefreshIndicator(
                                        onRefresh: payController.getDataRateTopup,
                                        child:  Text('Belum Ada Transaksi'),
                                      ),
                                    );
                                  } else {
                                    for  (var item in topUpData) {
                                      kodebank = item.namaBank;

                                    }
                                    return Column(
                                      children: [
                                        // for (var item in topUpData)
                                        // Text('${item['price']}')
                                        Text(
                                          kodebank,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                                // Text(
                                //   '087212223993',
                                //   style: TextStyle(
                                //     fontWeight:
                                //     FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        // SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Atas Nama'),
                            Obx(() {
                              final data = payController.jsonPembayaran;
                              final topUpData = data
                                  .where((item) => item.namaBank == widget.data.namaBank)
                                  .toList();
                              if (topUpData.isEmpty) {
                                return Center(
                                  child: RefreshIndicator(
                                    onRefresh: payController.getDataRateTopup,
                                    child:  Text('Belum Ada Transaksi'),
                                  ),
                                );
                              } else {
                                for  (var item in topUpData) {
                                  namaRekBank = item.nama!;

                                }
                                return Column(
                                  children: [
                                    // for (var item in topUpData)
                                    // Text('${item['price']}')
                                    Text(
                                      namaRekBank,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }),
                            // Text('Jong Java',style: TextStyle(
                            //     fontWeight: FontWeight.bold
                            // )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('id Pembayaran'),
                            Obx(() {
                              final data = payController.responPembayaranWD;
                              return Text('$data',style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ));
                            }),
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
                            child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Nama Pengirim'),
                          ),
                        ),
                        Form(key: _formKey,child: textForm(namaPengirim, 'Masukkan Nama Pengirim', [FilteringTextInputFormatter.deny(RegExp(' '))], TextInputType.text, 'Masukkan Nama Pengirim', '', false)),

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
                                title:  Text('Pilih Bukti Pembayaran'),
                                // content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
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
                            });
                          },
                          child: _image == null ?
                          Container(
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
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: CupertinoColors.activeBlue, // warna latar belakang
                            ),
                            onPressed: () {
                              if(_image != null && namaPengirim.text.isNotEmpty){
                                payController.KirimBuktiTopup(namaPengirim.text, _image!);
                                // Get.offAllNamed();
                              }else{
                                showDialog(context: context,builder: (context) {
                                  return AlertDialog(
                                    title: Center(
                                        child: Icon(Icons.warning)),
                                    content: Text('Nama dan Bukti Harus diisi'),
                                    alignment: Alignment.center,

                                    // content: Text('Bank Harus Dipilih'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ],
                                  );
                                },);
                              }
                              print(_image);
                              // kirimData();
                              // _sendData();

                              // _confirmWithdraw(context);
                            },
                            child: Obx(() =>
                            payController.isLoading.value ? CircularProgressIndicator():
                            Text(style: TextStyle(
                                color: Colors.white
                            ),'Bayar'),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ), onWillPop: () async {
          // Menampilkan dialog konfirmasi
          return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Icon(Icons.warning),
                backgroundColor: CupertinoColors.systemYellow,
                content: Text('Apakah Anda ingin keluar dari Pembayaran'),
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
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          ) ?? false;
        },),
      ),
    );
  }
  Future<void> _sendData() async {
    var id = payController.responPembayaran;
    try {

      String apiUrl = '$BASE_URL/payment/top_up/$id'; // Ganti dengan URL API yang sesuai
      var uri = Uri.parse(apiUrl);

      var request = http.MultipartRequest('POST', uri)
        ..fields['nama'] = namaPengirim.text
        ..files.add(http.MultipartFile.fromBytes(
          'bukti_pembayaran',
          _image!.readAsBytesSync(),
          filename: 'image.jpg',
        ));

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      var response = await http.Response.fromStream(await request.send());

      Navigator.pop(context); // Tutup dialog loading

      if (response.statusCode == 200) {
        print('Data berhasil dikirim: ${response.body}');
      } else {
        print('Gagal mengirim data. Response: ${response.body}');
      }
    } catch (e) {
      print('Terjadi error: $e');
    }
  }

  void kirimData(){
    Map<String, dynamic> data = {
      "nama": namaPengirim.text,
      "bukti_pembayaran": _image!.readAsBytesSync()
    };

    // Mengirim data ke API
    print('$data');
    // payController.KirimBukti(data);



  }
}


