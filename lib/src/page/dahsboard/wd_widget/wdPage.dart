import 'package:bakulpay/src/page/dahsboard/wd_widget/pembayaran_wd.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
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
                  child: DropdownButton<String>(
                    hint: const Text('Pilih Jenis Produk'),
                    isExpanded: true,
                    value: pilihInstansi,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          pilihInstansi = newValue;
                        });
                      }
                    },
                    items: pilihanInstansi.map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(height: 16),
                if (pilihInstansi != null)
                  textForm(dollarController,"Masukkan Jumlah \$",[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],TextInputType.number, 'Masukkan Jumlah','',false),
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

                SizedBox(height: 20),
                if (pilihInstansi != null)
                  Container(
                    child: DropdownButton<String>(
                      hint: Text('Pilih Bank'),
                      isExpanded: true,
                      value: bankPilihan,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            bankPilihan = newValue;
                          });
                        }
                      },
                      items: pilihanBank.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
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
