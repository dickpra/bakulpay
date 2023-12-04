import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class pembayaranWd extends StatefulWidget {
  final String produk;
  final int amount;
  final String bank;
  final String rekening;
  final String blockChain;

  pembayaranWd({required this.produk, required this.amount, required this.bank, required this.rekening, required this.blockChain});

  @override
  _pembayaranWdState createState() => _pembayaranWdState();
}

class _pembayaranWdState extends State<pembayaranWd> {
  int totalPayment = 0;
  String? selectedPaymentMethod;
  List<String> paymentMethods = ['Dana','OVO'];
  Map<String, String> paymentMethodIcons = {
    'Dana': 'assets/images/paypal.png',
    'OVO': 'assets/images/paypal.png',
    'GoPay': 'assets/gopay_icon.png',
  };
  File? _image;

  int satuanHargaa = 14000;

  @override
  void initState() {
    super.initState();
    // Menghitung total pembayaran berdasarkan jumlah dollar dan satuan dollar
    totalPayment = widget.amount * satuanHargaa;
  }

  @override
  Widget build(BuildContext context) {

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
        title: Text('Withdraw'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //     height: 120,
              //     width: MediaQuery.sizeOf(context).width,
              //     child: Image.asset('assets/images/paypal.png')
              // ),
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
                                              Text('${widget.produk}',style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ))
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
                                              Text('Rate Withdraw'),
                                              Text('Rp.${currencyFormat.format(satuanHargaa)}',style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              )),
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
                        padding: const EdgeInsets.all(8.0),
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
                                                  Text('Detail Pembayaran', style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  )),
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
                                                  const Text('Jumlah yang diterima'),
                                                  Text('Rp.${currencyFormat.format(totalPayment)}',style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  )),
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.blue
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.blue
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.monetization_on_sharp, color: Colors.blue,),
                                            SizedBox(width: 10),
                                            Text('Metode Pencairan', style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(widget.bank,style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  )),

                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Rekening Penerima'),
                                  Text(widget.rekening,style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  )),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Jumlah yang diterima'),
                                  Text('Rp.${currencyFormat.format(totalPayment)}',style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                              Text('Total Pembayaran',style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              )),
                              Text('\$${widget.amount}',style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 5),

              ///BLOCKChain
              if(widget.produk.contains('USDT') || widget.produk.contains('BUSD'))
                BLOCKCHAIN(_formKey, namaPengirim, context, pickKamera, pickGallery),

              ///Skrill
              if(widget.produk.contains('Paypal') ||widget.produk.contains('Skrill') || widget.produk.contains('Perfect Money') || widget.produk.contains('Payeer'))
                Skrill(_formKey, namaPengirim, context, pickKamera, pickGallery),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {

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
                  child: Text('Konfirmasi'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Row BLOCKCHAIN(GlobalKey<FormState> formKey, TextEditingController namaPengirim, BuildContext context, Future<void> Function() pickKamera, Future<void> Function() pickGallery) {
    return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),'Silahkan Transfer ke'),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)
                                    ,widget.produk),
                              ),
                            ),

                            // if(selectedPaymentMethod!.contains('Dana'))
                              Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.green
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(widget.blockChain,style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            )),
                                          ),
                                          // Text('Rekening/e-wallet'),
                                          if(widget.blockChain.contains('BEP20') || widget.produk.contains('ERC20') || widget.blockChain.contains('Polygon'))
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                iconSize: 15,
                                                color: Colors.blue,
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: '0x35D4C762eAdde62037ce52f6FD7C155Fc1897caF'));
                                                },
                                                icon: Icon(Icons.copy),
                                              ),
                                              Text(
                                                '0x35D4C762eAdde62037ce52f6FD7C155Fc1897caF',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if(widget.blockChain.contains('TRC20'))
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  iconSize: 15,
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    Clipboard.setData(ClipboardData(text: 'TR3Y5cYicN7beNMCvgMhx2BNYYgGqid4MY'));
                                                  },
                                                  icon: Icon(Icons.copy),
                                                ),
                                                Text(
                                                  'TR3Y5cYicN7beNMCvgMhx2BNYYgGqid4MY',
                                                  style: TextStyle(
                                                    fontSize: 12,
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
                                          child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Nama Pengirim'),
                                        ),
                                      ),
                                      Form(key: formKey,child: textForm(namaPengirim, 'Masukkan Nama Pengirim', [FilteringTextInputFormatter.deny(RegExp(' '))], TextInputType.text, 'Masukkan Nama Pengirim', '', false)),

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
                                    ],
                                  )
                              ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }
  Row Skrill(GlobalKey<FormState> formKey, TextEditingController namaPengirim, BuildContext context, Future<void> Function() pickKamera, Future<void> Function() pickGallery) {
    return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),'Silahkan Transfer ke'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)
                                    ,widget.produk),
                              ),
                            ),

                            // if(selectedPaymentMethod!.contains('Dana'))
                              Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.green
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(widget.produk,style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            )),
                                          ),
                                          // Text('Rekening/e-wallet'),
                                          if(widget.produk.contains('Paypal'))
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  iconSize: 15,
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    Clipboard.setData(ClipboardData(text: 'jj@gmail.com'));
                                                  },
                                                  icon: Icon(Icons.copy),
                                                ),
                                                Text(
                                                  'jj@gmail.com',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if(widget.produk.contains('Skrill'))
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                iconSize: 15,
                                                color: Colors.blue,
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: '7419012470192'));
                                                },
                                                icon: Icon(Icons.copy),
                                              ),
                                              Text(
                                                '7419012470192',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if(widget.produk.contains('Perfect Money'))
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  iconSize: 15,
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    Clipboard.setData(ClipboardData(text: '12312312342'));
                                                  },
                                                  icon: Icon(Icons.copy),
                                                ),
                                                Text(
                                                  '12312312342',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if(widget.produk.contains('Payeer'))
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  iconSize: 15,
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    Clipboard.setData(ClipboardData(text: '091238923813'));
                                                  },
                                                  icon: Icon(Icons.copy),
                                                ),
                                                Text(
                                                  '091238923813',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      const Row(
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
                                        child: const Column(
                                          children: [
                                            Text('Transfer total pembayaran sesuai dengan rincian diatas ke nomor rekening atas nama Jong Java.'),
                                            SizedBox(height: 10),
                                            Text('Biaya transaksi ditanggung pengguna,Lalu upload bukti transfer pada kolom yang disediakan dibawah ini.'),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Nama Pengirim'),
                                        ),
                                      ),
                                      Form(key: formKey,child: textForm(namaPengirim, 'Masukkan Nama Pengirim', [FilteringTextInputFormatter.deny(RegExp(' '))], TextInputType.text, 'Masukkan Nama Pengirim', '', false)),

                                      SizedBox(height: 20),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),'Upload Bukti Pembayaran'),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
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
                                    ],
                                  )
                              ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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

