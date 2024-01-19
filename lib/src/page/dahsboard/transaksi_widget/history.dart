import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/history_model.dart';
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

  String filter = '';

  @override
  void initState() {
    super.initState();
    payController.clearJsonDataTransaksi();
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

                List<model_history> filteredItems = data
                    .where((item) => item.type!.toLowerCase().contains(filter.toLowerCase()))
                    // .where((item) => item.status!.toLowerCase().contains(filter2.toLowerCase()))
                    .toList();
                if (data.isEmpty) {
                  return Center(
                      child: RefreshIndicator(
                      onRefresh: payController.getDataTransak,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/warningTX.png'),
                          Text('Kamu belum memiliki transaksi',style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold
                          ),),
                          Text('buat transaksi sekarang untuk melihatnya dihalaman ini',style: TextStyle(
                            fontSize: 13, color: Colors.grey
                          ),),
                        ],
                      )));
                } else {
                  return RefreshIndicator(
                      onRefresh: payController.getDataTransak,
                      child: ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => dataTransaksiPage(),
                              //   ),
                              // );
                              Get.to(DataTransaksiPage(filteredItems.elementAt(index)));
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

                        if(topup == 'true'){
                          setState((){
                            filter = 'Top-Up';
                          });
                        }if(topup == 'false'){
                          setState((){
                            filter = 'Withdraw';
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
                          backgroundColor: filterController.isTopUpSelected.value ? Color(0xff37398B) : Colors.white,
                        ),
                        child: Text('Top Up',style: TextStyle(
                          color: filterController.isTopUpSelected.value ? Colors.white : Color(0xff37398B),
                        ),),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          filterController.isTopUpSelected.value = false;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !filterController.isTopUpSelected.value ? Color(0xff37398B) : Colors.white,
                        ),
                        child: Text('Withdraw',style: TextStyle(
                          color: !filterController.isTopUpSelected.value ? Colors.white : Color(0xff37398B),
                        ),),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 10),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text('Produk',style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18
                  )),
                ),
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



Container Listdata(List<model_history> data, index) {
  return Container(

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
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.all(8),
    // decoration: BoxDecoration(
    //   color: Colors.white60,
    //   border: Border.all(),
    // ),
    child: Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Ikon
            Row(
              children: [
                if(data[index].product == 'Paypal')
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: Image(image: AssetImage('assets/images/payp.png'),),
                  ),
                ),if(data[index].product == 'Perfect Money')
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: Image(image: AssetImage('assets/images/perfectmoney.png'),),
                  ),
                ),if(data[index].product == 'Pay Owner' || data[index].product == 'Payooner')
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: Image(image: AssetImage('assets/images/nett.png'),),
                  ),
                ),if(data[index].product == 'Skrill')
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: Image(image: AssetImage('assets/images/skrill.png'),),
                  ),
                ),if(data[index].product == 'VCC')
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: Image(image: AssetImage('assets/images/visa.png'),),
                  ),
                ),if(data[index].product == 'Payeer')
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: Image(image: AssetImage('assets/images/payeer.png'),),
                  ),
                ),if(data[index].product == 'USDT')
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: Image(image: AssetImage('assets/images/busd-logo.png'),),
                  ),
                ),if(data[index].product == 'BUSD')
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 36,
                    child: Image(image: AssetImage('assets/images/busd-logo.png'),),
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data[index].type}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                    SizedBox(height: 5),
                    Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),'${data[index].product}'),
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
                    color: getStatusColor(data[index].status.toString()),
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
                SizedBox(height: 5),
                if(data[index].type == 'Top-Up' || data[index].type == 'TopUp' || data[index].type == 'Top Up')
                Text('Rp.${data[index].totalPembayaran}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                if(data[index].type == 'Withdraw')
                  Text('\$${data[index].totalPembayaran}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
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
                child: Text('${data[index].tanggal}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,))),
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Klik untuk Detail',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
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
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.orange;
    case 'success':
      return Colors.green;
    case 'failed':
      return Colors.red;
    default:
      return Colors.black; // Warna default jika status tidak dikenali
  }
}
