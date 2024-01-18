import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/pembayaran_wd.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WithdrawPage extends StatefulWidget {
  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {

  PayController payController = Get.put(PayController());
  List<String> pilihanInstansi = ['Paypal','Skrill', 'Perfect Money', 'Payeer', 'USDT', 'BUSD'];
  String? pilihInstansi;
  final _formKey = GlobalKey<FormState>();
  List<String> pilihanBank = [
    'Bank Jago',
    'Bank Mandiri',
    'Bank Neo',
    'BCA',
    'BNI',
    'BRI',
    'DANA',
    'GOPAY',
    'LinkAja',
    'OVO',
    'ShoopePay',
    'Seabank',
    'TMRW'
  ];
  String? bankPilihan;
  List<String> pilihanBlockchain = ['BEP20', 'ERC20', 'TRC20', 'Polygon', 'Solana'];
  String? pilihBlockChain;


  String selectedPaymentWd = '';



  TextEditingController dollarController = TextEditingController();
  TextEditingController nomorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Tab(
        child: Text('Withdraw', style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.bold
        )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Container(
                //   decoration: BoxDecoration(),
                //   child: const Align(
                //     child: Text(
                //       'Withdraw',
                //       style: TextStyle(
                //           fontSize: 25,
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    // width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade50),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx(() {
                      final data = payController.jsonWithdraw;
                      if (data.isEmpty) {
                        return Center(
                          child:  Text('Belum Ada'),
                        );
                      } else {
                        return DropdownButtonFormField<String>(
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            // disabledBorder: InputBorder.none,
                            // filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                          hint: Text('Pilih Jenis Produk'),
                          value: pilihInstansi, // Gunakan selectedPaymentMethod dari payController
                          // onChanged: (newValue) {
                          //   pilihInstansi = newValue;
                          // },
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                pilihInstansi = newValue;
                              });
                            }
                          },
                          items: payController.jsonWithdraw.map<DropdownMenuItem<String>>(
                                (paymentModel) {
                              String value = paymentModel.namaBank.toString();
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    Image.network(
                                      paymentModel.icons.toString(),
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
                    },),
                  ),
                ),
                SizedBox(height: 16),
                // Obx(() {
                //   var data = payController.selectedPaymentWd;
                //
                //   // selectedPaymentWd = data;
                //   if(data.isEmpty){
                //     return Text('data');
                //   }else
                //   // Tidak perlu lagi menggunakan if karena myValue diinisialisasi dengan nilai default.
                //   return Text(data.toString());
                // }),
                if (pilihInstansi != null)
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Divider()),
                          ],
                        ),
                        Align
                          (alignment: Alignment.centerLeft,
                            child: Text('Masukkan Jumlah (\$)', style: TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold
                            ),)),
                        TextFormField(
                          controller: dollarController,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                            hintText: '\$',
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Masukkan Jumlah!';
                            }
                            final double? amount = double.tryParse(value);
                            if (amount! <= 4.9) {
                              return 'Jumlah Harus lebih dari \$5';
                            }
                            return null;
                          },
                        ),
                        // textForm(dollarController,"Masukkan Jumlah \$",[
                        //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        // ],TextInputType.number, 'Masukkan Jumlah','',false),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                          ],
                        ),
                      ],
                    ),
                  ),

                ///USD
                // SizedBox(height: 20),
                if (pilihInstansi != null && pilihInstansi!.contains('USDT') || pilihInstansi != null && pilihInstansi!.contains('BUSD'))
                  Container(
                    // width: 200,
                    decoration: BoxDecoration(),
                    child: DropdownButton<String>(
                      hint: Text('Pilih BlockChain'),
                      isExpanded: true,
                      value: pilihBlockChain,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            pilihBlockChain = newValue;
                          });
                        }
                      },
                      items: pilihanBlockchain.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),

                ///BANK
                // SizedBox(height: 20),
                if (pilihInstansi != null)
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Divider()),
                          ],
                        ),
                        Obx(() {
                          final data = payController.jsonPembayaran;
                          // print('daasdasdasdsa $data');
                          if (data.isEmpty) {
                            return Center(
                              child:  Text('Belum Ada Metode Pembayaran'),
                            );
                          } else {
                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: InputBorder.none
                              ),
                              hint: Row(children: [ Icon(CupertinoIcons.money_dollar_circle, color: Color(0xff7AA4F5),),SizedBox(width: 10),Text('Metode Pencairan', style: TextStyle(color: Color(0xff7AA4F5), fontSize: 18),)]),
                              value: bankPilihan, // Gunakan selectedPaymentMethod dari payController
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    bankPilihan = newValue;
                                  });
                                }
                              },
                              items: payController.jsonPembayaranWd.map<DropdownMenuItem<String>>(
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
                        },),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                          ],
                        ),
                      ],
                    )
                  ),
                // SizedBox(height: 20),

                if (bankPilihan != null)
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Divider()),
                        ],
                      ),
                      TextFormField(
                        controller: nomorController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                          labelText: 'Nomor Rekening/E-Wallet',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan Nomor Rekening';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 16),
                if (bankPilihan != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CupertinoColors.activeBlue, // warna latar belakang
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Implement sign up logic
                    }
                    _confirmWithdraw(context);

                  },
                  child: Text(style: TextStyle(
                    color: Colors.white
                  ),'Konfirmasi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmWithdraw(context) {
    if(pilihInstansi!.contains('USDT') && pilihBlockChain == null || pilihInstansi!.contains('BUSD') && pilihBlockChain == null){

      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title:  Icon(Icons.close,
          color: Colors.red, size: 100),
          content: const Text('BlockChain Harus dipilih'),

          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {

                Navigator.pop(context);
              },
            ),
          ],
        );
      });
    } else if (_formKey.currentState!.validate()) {

      // Do something with the confirmed values
      print('Opsi yang dipilih: $pilihInstansi');
      print('Jumlah: ${dollarController.text}');
      print('Bank: $bankPilihan');
      print('Nomor Rekening: ${nomorController.text}');
      print('BlockChain: $pilihBlockChain');
      Navigator.push(
          context,
      MaterialPageRoute(
        builder: (context) => pembayaranWd(
            produk: pilihInstansi.toString(),
            blockChain: pilihBlockChain.toString(),
            amount: int.parse(dollarController.text),
            bank: bankPilihan.toString(),
            rekening: nomorController.text),
      ),
      );
    }
  }
}
