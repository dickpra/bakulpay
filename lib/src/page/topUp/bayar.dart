import 'dart:io';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/pembayaran_wd.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';



class BuatPesanan extends StatefulWidget {
  final dynamic email;
  final dynamic jumlah;
  final dynamic total_pembayaran;
  final dynamic nama_bank;
  final dynamic kode_bank_client;
  final dynamic nama_pengirim;
  final dynamic bukti_pembayaran;



  BuatPesanan({required this.email, this.jumlah, this.total_pembayaran, this.nama_bank, this.kode_bank_client, this.nama_pengirim, this.bukti_pembayaran});

  @override
  State<BuatPesanan> createState() => _BuatPesananState();
}

class _BuatPesananState extends State<BuatPesanan> {

  PayController payController = Get.put(PayController());
  File? _image;
  final _formKey = GlobalKey<FormState>();
  // Membuat instance NumberFormat
  final currencyFormat = NumberFormat.decimalPattern('en_US');
  TextEditingController namaPengirim = TextEditingController();
  String kodebank = '';


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
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Row(
                            children: [
          
                              Text(
                                  'Bank ${widget.nama_bank}',
                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 10),
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
                              widget.total_pembayaran,
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
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
                            Text('Rekening ${widget.nama_bank}'),
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
                                  final data = payController.jsonPembayaran;
                                  // final bank = data;
                                  // print(data);
          
                                  final topUpData = data
                                      .where((item) => item.namaBank == widget.nama_bank)
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
                                      kodebank = item.noRekening;
          
                                    }
                                    return Column(
                                      children: [
                                        // for (var item in topUpData)
                                        // Text('${item['price']}')
                                        Text(
                                          kodebank,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                                title:  Text('Pilih Bukti Pembayaran'),
                                // content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Kamera'),
                                    onPressed: () {
                                      Navigator.pop(context);
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
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: CupertinoColors.activeBlue, // warna latar belakang
                            ),
                            onPressed: () {

                              // _confirmWithdraw(context);
                            },
                            child: Text(style: TextStyle(
                                color: Colors.white
                            ),'Selanjutnya'),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Text(widget.nama_bank),
// Text(widget.email),
// Text(widget.jumlah),
// Text(widget.kode_bank_client),