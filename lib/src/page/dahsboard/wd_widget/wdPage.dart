import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/pembayaran_wd.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {

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
                Container(
                  // width: 200,
                  decoration: const BoxDecoration(),
                  child: Obx(() {
                    final data = payController.jsonWithdraw;

                    if (data.isEmpty) {
                      return Center(
                        child:  Text('Belum Ada Metode Pembayaran'),
                      );
                    } else {
                      return DropdownButtonFormField<String>(
                        hint: Text('Pilih Metode Pencairan'),
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
                                  // Sesuaikan dengan struktur objek model Anda
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
                  textForm(dollarController,"Masukkan Jumlah \$",[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],TextInputType.number, 'Masukkan Jumlah','',false),

                ///USD
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                if (pilihInstansi != null)
                  Container(
                    child: Obx(() {
                      final data = payController.jsonPembayaran;
                      // print('daasdasdasdsa $data');
                      if (data.isEmpty) {
                        return Center(
                          child:  Text('Belum Ada Metode Pembayaran'),
                        );
                      } else {
                        return DropdownButtonFormField<String>(
                          hint: const Text('Pilih Bank Pencairan'),
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
                    },)
                  ),
                SizedBox(height: 20),

                if (bankPilihan != null)
                  TextFormField(
                    controller: nomorController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      labelText: 'No Rekening/E-Wallet',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                SizedBox(height: 16),
                if (bankPilihan != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CupertinoColors.activeBlue, // warna latar belakang
                  ),
                  onPressed: () {
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
