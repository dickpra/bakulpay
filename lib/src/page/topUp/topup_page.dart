import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/page/topUp/pembayaran.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Topup extends StatelessWidget {
  PayController payController = Get.put(PayController());
  final _formKey = GlobalKey<FormState>();
  String produkTopup = '';
  String iconNetwork = '';

  String icon = Get.arguments[0];
  String title = Get.arguments[1];
  TextEditingController rekController = TextEditingController();
  TextEditingController dollarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() {
            var data = payController.jsonRate;
            var bank = data['data'];
            var topUpData = bank
                .where((item) => item['nama_bank'] == title)
                .toList();
            if (topUpData.isEmpty) {
              return Center(
                  child: RefreshIndicator(
                      onRefresh: payController.getDataRateTopup,
                      child: const Text('Belum Ada Transaksi')));
            } else {
              for (var item in topUpData){
                produkTopup = '${item['nama_bank']}';
                iconNetwork = '${item['icons']}';
              }
              return Text('Top up $produkTopup',style: TextStyle(
                  fontWeight: FontWeight.bold
              ));
            }
          }),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                      width: MediaQuery.sizeOf(context).width,
                      child:
    // Obx(() {
                        // var data = payController.jsonRate;
                        // var bank = data['data'];
                        // var topUpData = bank
                        //     .where((item) => item['nama_bank'] == 'Paypal')
                        //     .toList();
                        // // print('daasdasdasdsa $data');
                        // if (topUpData.isEmpty) {
                        //   return Center(
                        //       child: const Text('Belum Ada Transaksi'));
                        // } else {
                        //   for (var item in topUpData){
                        //     iconNetwork = '${item['icons']}';
                        //   }
                          Image.network(icon,scale: 0.5,)
                        // }
                      // }),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Text(title=="Paypal"?"E-Mail Paypal":title=="Pay Owner"?'E-Mail Payooner':title=="Skrill"?'E-Mail Skrill':"Masukkan Uid", style: TextStyle(
                          fontSize: 15,
                      ),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: rekController,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15, fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        hintText: title=="Paypal"?"E-Mail Paypal":title=="Pay Owner"?'E-Mail Payooner':title=="Skrill"?'E-Mail Skrill':"Masukkan Uid",
                        // contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        // labelText: 'Masukkan Jumlah \$',
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                          // color: Colors.blue,
                        ),
                      ),
                      keyboardType: TextInputType.text,
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
                  ),
                  // textForm2(rekController,title=="Paypal"?"Masukkan E-Mail Paypal":title=="Pay Owner"?'Masukkan E-Mail Payooner':title=="Skrill"?'Masukkan E-Mail Skrill':"Masukkan Uid",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text,title=="Paypal"?'Masukkan E-Mail':title=="Pay Owner"?'Masukkan E-Mail':title=="Skrill"?'Masukkan E-Mail':"Masukkan Uid",title=="Pay Owner"?'@':title=="Paypal"?'@':title=="Skrill"?'@':'',false),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Text('Masukkan Jumlah (\$)', style: TextStyle(
                          fontSize: 15,
                      ),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: dollarController,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        hintText: '\$',

                        border: InputBorder.none,
                        labelStyle: TextStyle(
                          // color: Colors.blue,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],

                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Masukkan Jumlah!';
                        }
                        final double? amount = double.tryParse(value);
                        if (amount! <= 5.0) {
                          return 'Jumlah Harus lebih dari \$5';
                        }
                        return null;
                      },
                    ),
                  ),
                  // textForm2(rekController,title=="Paypal"?"Masukkan E-Mail Paypal":title=="Pay Owner"?'Masukkan E-Mail Payooner':title=="Skrill"?'Masukkan E-Mail Skrill':"Masukkan Uid",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text,title=="Paypal"?'Masukkan E-Mail':title=="Pay Owner"?'Masukkan E-Mail':title=="Skrill"?'Masukkan E-Mail':"Masukkan Uid",title=="Pay Owner"?'@':title=="Paypal"?'@':title=="Skrill"?'@':'',false),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                    ],
                  ),
                  // SizedBox(height: 16),
                  // textForm2(dollarController,"Masukkan Jumlah \$",[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],TextInputType.number, 'Masukkan jumlah','',false),
                  SizedBox(height: 50),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: CupertinoColors.activeBlue, // warna latar belakang
                        ),
                        onPressed: () {
                          _confirmWithdraw(context);
                        },
                        child: Text(style: TextStyle(
                            color: Colors.white
                        ),'Selanjutnya'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmWithdraw(context) {
    if (_formKey.currentState!.validate()) {
      // Do something with the confirmed values
      print('Jumlah: ${dollarController.text}');
      print('Nomor Rekening: ${dollarController.text}');


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PembayaranTopUp(
            rekProduk: rekController.text,
            amount: int.parse(dollarController.text),
            produk: title,
            iconNetwork: icon,
          ),
        ),
      );
    }
  }
}


class TopupPerfectMoney extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final produkTopup = 'Perfect Money';


  TextEditingController uidController = TextEditingController();
  TextEditingController dollarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Top up Perfect Money'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(),
                  //   child:
                  //   const Align(
                  //     child: Text(
                  //       'Top Up Paypal',
                  //       style: TextStyle(
                  //           fontSize: 25,
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                      height: 150,
                      width: MediaQuery.sizeOf(context).width,
                      child: Image.asset('assets/images/perfectmoney.png')
                  ),
                  SizedBox(height: 30),
                  textForm(uidController,"Masukkan Uid",[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],TextInputType.number, 'Masukkan uid','',false),
                  SizedBox(height: 16),
                  textForm(dollarController,"Masukkan Jumlah \$",[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],TextInputType.number, 'Masukkan jumlah','',false),
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CupertinoColors.activeBlue, // warna latar belakang
                      ),
                      onPressed: () {

                        _confirmWithdraw(context);
                      },
                      child: Text(style: TextStyle(
                          color: Colors.white
                      ),'Selanjutnya'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmWithdraw(context) {
    if (_formKey.currentState!.validate()) {
      // Do something with the confirmed values
      print('Jumlah: ${dollarController.text}');
      print('Nomor Rekening: ${dollarController.text}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PembayaranTopUp(
            rekProduk: uidController.text,
            amount: int.parse(dollarController.text),
            produk: produkTopup, iconNetwork: '',
          ),
        ),
      );
    }
  }
}


class TopupPayOwner extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final produkTopup = 'Pay Owner';


  TextEditingController uidController = TextEditingController();
  TextEditingController dollarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Top up Pay Owner'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                      height: 150,
                      width: MediaQuery.sizeOf(context).width,
                      child: Image.asset('assets/images/perfectmoney.png')
                  ),
                  SizedBox(height: 30),
                  textForm(uidController,"Masukkan Uid",[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],TextInputType.number, 'Masukkan uid','',false),
                  SizedBox(height: 16),
                  textForm(dollarController,"Masukkan Jumlah \$",[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],TextInputType.number, 'Masukkan jumlah','',false),
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CupertinoColors.activeBlue, // warna latar belakang
                      ),
                      onPressed: () {

                        _confirmWithdraw(context);
                      },
                      child: Text(style: TextStyle(
                          color: Colors.white
                      ),'Selanjutnya'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmWithdraw(context) {
    if (_formKey.currentState!.validate()) {
      // Do something with the confirmed values
      print('Jumlah: ${dollarController.text}');
      print('Nomor Rekening: ${dollarController.text}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PembayaranTopUp(
            rekProduk: uidController.text,
            amount: int.parse(dollarController.text),
            produk: produkTopup, iconNetwork: '',
          ),
        ),
      );
    }
  }
}
