import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/rate_model.dart';
import 'package:bakulpay/src/model/test_model.dart';
import 'package:bakulpay/src/page/topUp/topup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ratePage extends StatefulWidget {
  const ratePage({super.key});

  @override
  State<ratePage> createState() => _ratePageState();
}

class _ratePageState extends State<ratePage> {

  PayController payController = Get.put(PayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: Text('Rate Hari Ini'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.filter_list),
      //       onPressed: () {
      //         // Aksi yang dijalankan saat ikon filter ditekan
      //         // Misalnya, tampilkan dialog filter atau navigasi ke halaman filter
      //         print('Ikon Filter Ditekan');
      //       },
      //     ),
      //   ],
      // ),
      // appBar: AppBar(
      //   title: Text('Judul AppBar'),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
      appBar: const Tab(
        // icon: Icon(Icons.ice_skating),
        child: Text('Rate Hari ini', style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.bold
        )),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              // color: Colors.blue,
              child: Obx(() {
                final data = payController.jsonDataRate;
                // print('daasdasdasdsa $data');
                if (data.isEmpty) {
                  return Center(
                      child: RefreshIndicator(
                          onRefresh: payController.getDataTransak,
                          child: const Text('Belum Ada Transaksi')));
                } else {
                  return RefreshIndicator(
                      onRefresh: payController.getDataRate,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if(data[index].type!.contains('Top Up')&&data[index].namaBank!.contains('Paypal')){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TopupPaypal(),
                                  ),
                                );
                              }
                            },
                            child: ListRate(data, index),
                          );
                        },
                      ));
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

Container ListRate(RxList<rate_model> data, index) {
  final currencyFormat = NumberFormat.decimalPattern('en_US');
  final myInt = int.parse(data[index].price);
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
                // if(data[index].namaBank!.contains('Paypal'))
                // CircleAvatar(
                //   radius: 36,
                //   child: Image(image: AssetImage('assets/images/payp.png')),
                // ),
                // if(data[index].namaBank!.contains('Dana'))
                // CircleAvatar(
                //   radius: 36,
                //   child: Image(image: AssetImage('assets/images/dana.png')),
                // ),
                CircleAvatar(
                  radius: 36,
                  child: Image.network('${data[index].icons}'),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),'${data[index].namaBank}'),
                    Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),'${data[index].type}'),
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
                Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),'Rp.${currencyFormat.format(myInt)}'),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
