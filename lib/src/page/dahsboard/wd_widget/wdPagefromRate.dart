import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/pembayaran_wd.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class WithdrawPageRate extends StatefulWidget {
  @override
  _WithdrawPageRateState createState() => _WithdrawPageRateState();
}

class _WithdrawPageRateState extends State<WithdrawPageRate> {

  PayController payController = Get.put(PayController());
  String namaBankWD = Get.arguments[0];
  final _formKey = GlobalKey<FormState>();
  String? bankPilihan;
  String? blockChain;
  String? pilihBlockChain;
  String selectedPaymentWd = '';

  String? selectedValue;
  bool isFormVisible = false;


  TextEditingController dollarController = TextEditingController();
  TextEditingController nomorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Tab(
          child: Text('Withdraw', style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold
          )),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
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
                        child: Obx((){
                              final data = payController.jsonWithdraw;
                              final Itemdrop = data
                                  .where((item) => item.namaBank == namaBankWD)
                                  .toList();
                              // print('daasd
                              if(data.isEmpty){
                                return Center(
                                  child:  Text('Belum Ada'),
                                );
                              }else {
                                return DropdownButtonFormField2<String>(
                                isExpanded: true,
      
                                decoration: InputDecoration(
                                  // Add Horizontal padding using menuItemStyleData.padding so it matches
                                  // the menu padding when button's width is not specified.
                                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                  border: InputBorder.none,
                                  // Add more decoration..
                                ),
                                hint: const Text(
                                  'Pilih Jenis Produk',
                                  style: TextStyle(fontSize: 14),
                                ),
                                items: data.map((item) => DropdownMenuItem<String>(
                                  value: item.namaBank.toString(),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        item.icons.toString(),
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        item.namaBank,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select Produk.';
                                  }
                                  return null;
                                },
                                  value: namaBankWD.toString(), // Gunakan selectedPaymentMethod dari payController
                                  // onChanged: (newValue) {
                                  //   pilihInstansi = newValue;
                                  // },
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        dollarController.text = '';
                                        nomorController.text = '';
                                        blockChain = null;
                                        bankPilihan = null;
                                        namaBankWD = newValue;
      
                                      });
                                    }
                                  },
      
                                onSaved: (value) {
                                  selectedValue = value.toString();
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.only(right: 8),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_up_rounded,
                                    color: Color(0xFF37398B),
                                  ),
                                  iconSize: 24,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                              );
                              }
                            }
                        ),
                      ),
                    ),
      
                    SizedBox(height: 16),
      
                    if (namaBankWD != 'null')
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
                    if (namaBankWD != 'null' && namaBankWD.contains('USDT') || namaBankWD != 'null' && namaBankWD.contains('BUSD')|| namaBankWD != 'null' && namaBankWD.contains('USDC'))
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: Divider()),
                              ],
                            ),
                            Obx(() {
                              final data = payController.jsonDataRate;
                              var topUpData = data
                                  .where((item) => item.namaBank == namaBankWD)
                                  .where((item) => item.type == 'Withdraw')
                                  .toList();
                              if (data.isEmpty) {
                                return Center(
                                  child:  Text('Belum Ada'),
                                );
                              } else {
                                List<String> chainList = [];
                                for (var rateModel in topUpData) {
                                  var blockchainData = rateModel.blockchainData ?? [];
                                  for (var blockchainItem in blockchainData) {
                                    var namaBlockchain = blockchainItem.namaBlockchain;
                                    var rekeningWallet = blockchainItem.rekeningWallet;
                                    var type = blockchainItem.type;
      
                                    // Menambahkan namaBlockchain ke dalam chainList
                                    chainList.add(namaBlockchain!);
      
                                    // Lakukan sesuatu dengan informasi yang diakses
                                    print('Nama Blockchain: $namaBlockchain');
                                    print('Rekening Wallet: $rekeningWallet');
                                    print('Type: $type');
                                    print('---');
                                  }
                                }
                                return DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      border: InputBorder.none
                                  ),
                                  hint: Row(children: [ Icon(CupertinoIcons.money_dollar_circle, color: Color(0xff7AA4F5),),SizedBox(width: 10),Text('Pilih Blockchain', style: TextStyle(color: Color(0xff7AA4F5), fontSize: 18),)]),
                                  value: blockChain,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        blockChain = newValue;
                                      });
                                    }
                                  },
                                  items: chainList
                                      .map<DropdownMenuItem<String>>(
                                        (namaBlockchain) => DropdownMenuItem<String>(
                                      value: namaBlockchain,
                                      child: Row(
                                        children: [
                                          Text(namaBlockchain),
                                        ],
                                      ),
                                    ),
                                  )
                                      .toList(),
                                );
                              }
                            },),
                            Row(
                              children: [
                                Expanded(child: Divider()),
                              ],
                            ),
                          ],
                        ),
                      ),
      
                    ///BANK
                    // SizedBox(height: 20),
                    if (namaBankWD != 'null')
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
                        print('Opsi yang dipilih: $namaBankWD');
                        print('Jumlah: ${dollarController.text}');
                        print('Bank: $bankPilihan');
                        print('Nomor Rekening: ${nomorController.text}');
                        print('BlockChain: $pilihBlockChain');
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
        ),
      ),
    );
  }

  void _confirmWithdraw(context) {
    if(namaBankWD.contains('USDT') && blockChain == null
        // || pilihInstansi!.contains('BUSD') && pilihBlockChain == null
    ){

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
      print('Opsi yang dipilih: $namaBankWD');
      print('Jumlah: ${dollarController.text}');
      print('Bank: $bankPilihan');
      print('Nomor Rekening: ${nomorController.text}');
      print('BlockChain: $pilihBlockChain');

      Get.to(
          pembayaranWd(
              produk: namaBankWD.toString(),
              amount: int.parse(dollarController.text),
              bank: bankPilihan.toString(),
              rekening: nomorController.text,
              blockChain: blockChain.toString()
          ));
    }
  }
}
