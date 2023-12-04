import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/test_model.dart';
import 'package:bakulpay/src/page/dahsboard/transaksi_widget/transaksi_data/detail_transaksi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class transaksi extends StatefulWidget {
  const transaksi({super.key});

  @override
  State<transaksi> createState() => _transaksiState();
}

class _transaksiState extends State<transaksi> {

  PayController payController = Get.put(PayController());
  PayController filterController = Get.put(PayController());

  String filter2 = '';



  @override
  void initState() {
    super.initState();
    payController.getDataTransak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Riwayat Transaksi', style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
              // Aksi yang dijalankan saat ikon filter ditekan
              // Misalnya, tampilkan dialog filter atau navigasi ke halaman filter
              print('Ikon Filter Ditekan');
            },
          ),
        ],
      ),
      // appBar: Tab(
      //   child: Text('Riwayat Transaksi', style: TextStyle(
      //     fontSize: 20,fontWeight: FontWeight.bold
      //   )),
      // ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              // color: Colors.blue,
              child: Obx(() {

                final data = payController.jsonDataTransaksi;

                List<test_model> filteredItems = data
                    .where((item) => item.produk!.toLowerCase().contains(filter2.toLowerCase()))
                    // .where((item) => item.status!.toLowerCase().contains(filter2.toLowerCase()))
                    .toList();
                // print('daasdasdasdsa $data');
                if (data.isEmpty) {
                  return Center(
                      child: RefreshIndicator(
                      onRefresh: payController.getDataTransak,
                      child: const Text('Belum Ada Transaksi')));
                } else {
                  return RefreshIndicator(
                      onRefresh: payController.getDataTransak,
                      child: ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => dataTransaksiPage(),
                                ),
                              );
                            },
                            child: Listdata(filteredItems, index),
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
  void _showFilterDialog() {
    List<bool> isSelected = [true,false]; // Indeks 0: Topup, Indeks 1: Withdraw
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child:  Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Filter Transaksi',style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15
                    )),
                    ElevatedButton(
                      onPressed: () {
                        var topup = filterController.isTopUpSelected.toString();
                        print('asuu $topup');
                        if(topup.contains('true')){
                          setState((){
                            filter2 = 'Top Up';
                          });
                        }if(topup.contains('false')){
                          setState((){
                            filter2 = 'Withdraw';
                          });
                        }
                      },
                      child: Text('Konfirm'),
                    ),
                  ],
                ),
                // TextField(
                //   onChanged: (value) {
                //     setState(() {
                //       filter2 = value;
                //     });
                //   },
                //   decoration: InputDecoration(
                //     labelText: 'Filter',
                //     hintText: 'Type to filter items',
                //   ),
                // ),
                SizedBox(height: 30),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          filterController.isTopUpSelected.value = true;
                        },
                        style: ElevatedButton.styleFrom(
                          primary: filterController.isTopUpSelected.value ? Colors.blue : Colors.grey,
                        ),
                        child: Text('Top Up'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          filterController.isTopUpSelected.value = false;
                        },
                        style: ElevatedButton.styleFrom(
                          primary: !filterController.isTopUpSelected.value ? Colors.blue : Colors.grey,
                        ),
                        child: Text('Withdraw'),
                      ),
                    ],
                  );
                }),
                Obx(() {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxListTile(
                            title: const Text('Paypal'),
                            value: filterController.isPaypalSelected.value,
                            onChanged: (newValue) {
                              filterController.isPaypalSelected.value = newValue!;
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Skrill'),
                            value: filterController.isSkrillSelected.value,
                            onChanged: (newValue) {
                              filterController.isSkrillSelected.value = newValue!;
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Perfect Money'),
                            value: filterController.isPerfectMoneySelected.value,
                            onChanged: (newValue) {
                              filterController.isPerfectMoneySelected.value = newValue!;
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Payeer'),
                            value: filterController.isPayeerSelected.value,
                            onChanged: (newValue) {
                              filterController.isPayeerSelected.value = newValue!;
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('USDT'),
                            value: filterController.isUsdtSelected.value,
                            onChanged: (newValue) {
                              filterController.isUsdtSelected.value = newValue!;
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('BUSD'),
                            value: filterController.isBusdSelected.value,
                            onChanged: (newValue) {
                              filterController.isBusdSelected.value = newValue!;
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('VCC'),
                            value: filterController.isVccSelected.value,
                            onChanged: (newValue) {
                              filterController.isVccSelected.value = newValue!;
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Neteller'),
                            value: filterController.isNetellerSelected.value,
                            onChanged: (newValue) {
                              filterController.isNetellerSelected.value = newValue!;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          
              ],
            ),
          ),
        );
      },
    );
  }



}



Container Listdata(List<test_model> data, index) {
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
                // if(data[index].produk!.contains('produk 3'))
                CircleAvatar(
                  radius: 36,
                  child: Image(image: AssetImage('assets/images/busd-logo.png')),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),'Top-Up'),
                    Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),'${data[index].produk}'),
                  ],
                ),

              ],
            ),
            /// Status
            Column(
              children: [
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text(
                      '${data[index].status}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),'Rp.33.798,00'),
              ],
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Tanggal',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,))),
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Detail',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

