import 'dart:io';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/model_topup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

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


  String rateWD = '';
  String totalTagihan = '';
  PayController payController = Get.put(PayController());
  int totalPayment = 0;
  String? selectedPaymentMethod;
  List<String> paymentMethods = ['Dana','OVO'];
  Map<String, String> paymentMethodIcons = {
    'Dana': 'assets/images/paypal.png',
    'OVO': 'assets/images/paypal.png',
    'GoPay': 'assets/gopay_icon.png',
  };

  String iconBank = '';


  @override
  void initState() {
    super.initState();
    // Menghitung total pembayaran berdasarkan jumlah dollar dan satuan dollar
    // totalPayment = widget.amount * satuanHargaa;
  }

  @override
  Widget build(BuildContext context) {


    final currencyFormat = NumberFormat.decimalPattern('en_US');


    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Withdraw'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //     height: 120,
              //     width: MediaQuery.sizeOf(context).width,
              //     child: Image.asset('assets/images/paypal.png')
              // ),
              // if(widget.produk.toString().contains('Skrill'))
              //   Center(child: Image.asset('assets/images/skrill.png',scale: 20,)),
              ///Ikon
              Obx(() {
                final data = payController.jsonWithdraw;
                // final bank = data;
                // print(data);

                final topUpData = data
                    .where((item) => item.namaBank == widget.produk)
                    .toList();

                if (topUpData.isEmpty) {
                  return Center(
                      child: const Text('Belum Ada'));
                } else {
                  for (var item in topUpData){
                    iconBank = item.icons;

                  }
                  return Center(child: Image.network(iconBank,scale: 0.3,));
                }
              }),
              const SizedBox(height: 20,),
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
                                  Row(
                                    children: [
                                      Expanded(child: Divider(color: Colors.grey,)),
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
                                              Expanded(child: Text('Jenis Produk')),
                                              Expanded(
                                                child: Text('${widget.produk}',style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                )),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text('Jumlah')),
                                              Expanded(
                                                child: Text('\$${widget.amount}',style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                )),
                                              ),
                                            ],
                                          ),
                                          if(widget.blockChain != 'null')
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text('Chain')),
                                              Expanded(
                                                child: Text('${widget.blockChain}',style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                )),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text('Rate Withdraw')),

                                              Expanded(
                                                child: Obx(() {
                                                  var data = payController.jsonRateWd;
                                                  var bank = data['data'];
                                                  var topUpData = bank
                                                      .where((item) => item['nama_bank'] == widget.produk)
                                                      .toList();
                                                  // print('daasdasdasdsa $data');
                                                  if (topUpData.isEmpty) {
                                                    return Center(
                                                        child: const Text('Belum Ada Transaksi'));
                                                  } else {
                                                    for (var item in topUpData){
                                                      rateWD = currencyFormat.format(int.parse(item['price']));
                                                    }
                                                    return Row(
                                                      children: [

                                                        // Text('${item['price']}')
                                                        Expanded(
                                                          child: Text('Rp.$rateWD',style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          )),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                }),
                                              ),
                                              // Text('Rp.${currencyFormat.format(satuanHargaa)}',style: TextStyle(
                                              //     fontWeight: FontWeight.bold
                                              // )),
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
                                      Row(
                                        children: [
                                          Expanded(child: Divider(color: Colors.grey,)),
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
                                                  Expanded(child: const Text('Jumlah yang diterima')),
                                                  // Text('Rp.${currencyFormat.format(totalPayment)}',style: TextStyle(
                                                  //     fontWeight: FontWeight.bold
                                                  // )),
                                                  Expanded(
                                                    child: Obx(() {
                                                      final data = payController.jsonRateWd;
                                                      final bank = data['data'];
                                                      final topUpData = bank
                                                          .where((item) => item['nama_bank'] == widget.produk)
                                                          .toList();
                                                      // print('daasdasdasdsa $data');
                                                      if (topUpData.isEmpty) {
                                                        return Center(
                                                          child: Text('Belum Ada Transaksi'),
                                                        );
                                                      } else {
                                                        for  (var item in topUpData) {
                                                          totalTagihan = '${currencyFormat.format(int.parse(item['price'].toString()) * widget.amount)}';
                                                        }
                                                        return Row(
                                                          children: [
                                                            // for (var item in topUpData)
                                                            // Text('${item['price']}')
                                                            Expanded(
                                                              child: Text(
                                                                'Rp.$totalTagihan',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  // fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    }),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: Text('Biaya Transaksi')),
                                                  Expanded(
                                                    child: Text('Rp.0,00',style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                    )),
                                                  ),
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
                              Row(
                                children: [
                                  Expanded(child: Divider(color: Colors.grey,)),
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
                                  // Text('Rp.${currencyFormat.format(totalPayment) }',style: TextStyle(
                                  //     fontWeight: FontWeight.bold
                                  // )),

                                  Obx(() {
                                    final data = payController.jsonRateWd;
                                    final bank = data['data'];
                                    final topUpData = bank
                                        .where((item) => item['nama_bank'] == widget.produk)
                                        .toList();
                                    // print('daasdasdasdsa $data');
                                    if (topUpData.isEmpty) {
                                      return Center(
                                        child: Text('Belum Ada Transaksi'),
                                      );
                                    } else {
                                      for  (var item in topUpData) {
                                        totalTagihan = '${currencyFormat.format(int.parse(item['price'].toString()) * widget.amount)}';
                                      }
                                      return Column(
                                        children: [
                                          // for (var item in topUpData)
                                          // Text('${item['price']}')
                                          Text(
                                            'Rp.$totalTagihan',
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
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 80)),
                    backgroundColor: MaterialStatePropertyAll(Color(0xff37398B))
                  ),
                  onPressed: () {

                     print(totalTagihan);
                    kirimDataWd();
                  },
                  child: Obx(() =>
                  payController.isLoading.value ? CircularProgressIndicator():
                  Text(style: TextStyle(
                    color: Colors.white
                  ),'Selanjutnya'),
                  ),
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


  void kirimDataWd(){
    model_topup data = model_topup(
        userId: payController.respsonIdPengguna.value,
        product: widget.produk,
        priceRate: rateWD,
        jumlah: totalTagihan,
        totalPembayaran: widget.amount,
        namaBank: widget.bank,
        rekClient: widget.rekening
    );

    // Mengirim data ke API
    print('wasoo$data');
    payController.KirimWd(data);

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

