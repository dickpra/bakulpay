import 'package:bakulpay/src/model/test_model.dart';
import 'package:bakulpay/src/page/berita.dart';
import 'package:bakulpay/src/page/dahsboard/profil_widget/profil_widget.dart';
import 'package:bakulpay/src/page/dahsboard/rate/rate.dart';
import 'package:bakulpay/src/page/dahsboard/transaksi_widget/history.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/wdPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/test_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'home_widget/home.dart';

class DashBoard2 extends StatefulWidget {
  const DashBoard2({super.key});

  @override
  State<DashBoard2> createState() => _DashBoard2State();
}


class _DashBoard2State extends State<DashBoard2> {
  int currentPageIndex = 0;
  PayController payController = Get.put(PayController());

  @override
  void initState() {
    super.initState();
    payController.getDataTransak();
    payController.getDataRate();
    payController.getDataMenu();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Menampilkan dialog konfirmasi
          return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Konfirmasi'),
                content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Batal'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text('Keluar'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          ) ?? false;
        },
        child: SafeArea(child:
        Scaffold(
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: Colors.blue,
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                // icon: Badge(child: Icon(Icons.monetization_on_sharp)),
                label: 'Withdraw',
                icon: Icon(Icons.sell),
              ),
              NavigationDestination(
                icon:
                Icon(Icons.payments),
                // Badge(
                //   label: Text('2'),
                //   child: Icon(Icons.payment),
                // ),
                label: 'Transaksi',
              ),
              NavigationDestination(
                // icon: Badge(child: Icon(Icons.monetization_on_sharp)),
                label: 'Rate',
                icon: Icon(Icons.trending_up),
              ),
              NavigationDestination(
                // icon: Badge(child: Icon(Icons.monetization_on_sharp)),
                label: 'Profil',
                icon: Icon(Icons.person),
              ),
            ],
          ),
          body: <Widget>[
            /// Dashboard
             SingleChildScrollView(
               child: Column(
                 children: [
                   // profilDashboard(),
                   Align(
                     alignment: Alignment.topLeft,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                       child: Text(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),'Promo'),
                     ),
                   ),
                   PromoBanner(),
                   SizedBox(height: 20),
                   Align(
                     alignment: Alignment.topLeft,
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Text(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),'Top Up/Beli'),
                     ),
                   ),
                   BeliTopup(),
                   Align(
                     alignment: Alignment.topLeft,
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Text(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),'Berita Terkini'),
                     ),
                   ),
                   Container(
                     // height: 180,
                     child: NewsPage(),
                   )

                 ],
               ),
             ),

            /// Withdraw
            Container(
                child: SelectionPage(),
            ),

            /// Transaksi
            Container(
              decoration: BoxDecoration(
                // color: Colors.blue,
              ),
              child: transaksi(),
            ),

          /// Rate
            Container(
              child: ratePage(),
            ),


            /// Profil
            Container(
              child: profilWidget(),
            ),
          ][currentPageIndex],
        )),
        );
  }

  Container Listdata(RxList<test_model> data, index) {
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
                  CircleAvatar(
                    radius: 40,
                    child: Image(image: AssetImage('assets/images/busd-logo.png')),
                  ),
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
                        '${data[index].produk}',
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
                  child: Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),'Tanggal')),
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
}
