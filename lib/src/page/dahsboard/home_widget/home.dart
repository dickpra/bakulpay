import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:bakulpay/src/router/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/page/berita.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:bakulpay/src/page/dahsboard/more_page.dart';
import 'package:bakulpay/src/page/dahsboard/transaksi_widget/history.dart';
import 'package:bakulpay/src/page/test.dart';
import 'package:bakulpay/src/page/topUp/topup_page.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:get/get.dart';


class ProfilDashboard extends StatelessWidget {
  // final String? user;
  // profilDashboard({super.key, required this.user});

  PayController payController = Get.put(PayController());

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        // color: Colors.blue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Diganti menjadi MainAxisAlignment.spaceBetween
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            // alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang,',
                  style: TextStyle(fontSize: 12, color: Colors.grey), // Tambahkan warna teks
                ),
                Obx(() => Text(
                  payController.respsonNamaPgn.value,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                // Text(
                //   user?? 'User',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          ),
          // SizedBox(
          //   width: 20, // Sesuaikan lebar sesuai kebutuhan
          // ),
          Container(
            padding: EdgeInsets.only(left: 80),
            decoration: BoxDecoration(
              // color: Colors.grey,
            ),
            width: MediaQuery.of(context).size.width * 0.5, // Gunakan ukuran relatif untuk gambar
            child: Image.asset('assets/images/LOGO.png'),
          ),
        ],
      ),
    );
  }
}



class PageViewExample extends StatelessWidget {
  const PageViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      children: const <Widget>[
        Center(
          child: Text('First Page'),
        ),
        Center(
          child: Text('Second Page'),
        ),
        Center(
          child: Text('Third Page'),
        ),
      ],
    );
  }
}



class PromoBanner extends StatefulWidget {
  @override
  _PromoBannerState createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Automatic scroll behaviour
    _timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      int nextPage = _currentPageNotifier.value + 1;

      if (nextPage < 3) {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        _currentPageNotifier.value = 0;
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, // Sesuaikan dengan tinggi yang diinginkan
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
            },
            children: [
              PromoItem(imageUrl: 'https://static.wikia.nocookie.net/bakemonogatari1645/images/b/b9/Shinobu.png/revision/latest?cb=20161221045011'),
              PromoItem(imageUrl: 'https://asset.japan.travel/image/upload/v1671447928/yamanashi/Yamanashi_t_id382_1.jpg'),
              PromoItem(imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHwfp27o65DT03GXKuMEdrBmHjt9aXOy16CA&usqp=CAU'),
              // Tambahkan item promo sesuai kebutuhan
            ],
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: CirclePageIndicator(
                itemCount: 3, // Jumlah item promo
                currentPageNotifier: _currentPageNotifier,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromoItem extends StatelessWidget {
  final String imageUrl;

  PromoItem({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class BeliTopup extends StatelessWidget {
  PayController payController = Get.put(PayController());
  // final RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;

  // Future<void> fetchData() async {
  //   try {
  //     final response = await http.get(Uri.parse('http://192.168.18.33/api/payment/top%20up'));
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> parsedData = json.decode(response.body);
  //       jsonData.assignAll(List<Map<String, dynamic>>.from(parsedData['data']));
  //     } else {
  //       throw Exception('Gagal memuat data dari API');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        // ElevatedButton(
        //   onPressed: payController.getDataMenu,
        //   child: Text('Ambil Data API'),
        // ),
        // buildCircularMenuList()
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Obx(() {
            final data = payController.jsonDataMenu;
            List<Widget> menuButtons = [];

            for (int i = 0; i < data.length; i += 4) {
              List<Widget> rowItems = [];

              for (int j = i; j < i + 4 && j < data.length; j++) {
                rowItems.add(
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // if (jsonData[j]["data"])
                        //   print('Menu ${j + 1} tapped');
                        //   print('Menu ${j} tapped');

                          if(data[j].namaBank!.contains('USDT')||data[j].namaBank!.contains('BUSD')){
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => TopupPaypal(),
                            //   ),
                            // );
                          }else{
                            Get.toNamed(topUp,arguments: [data[j].icons as String,data[j].namaBank.toString()]);
                          }
                        // if(data[j].namaBank!.contains('Paypal')){
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => TopupPaypal(),
                          //     ),
                          //   );
                          // }
                          // if(data[j].namaBank!.contains('Perfect Money')){
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => TopupPerfectMoney(),
                          //     ),
                          //   );
                          // }
                      },
                      child: menuButtonTopup(
                        data[j].icons as String,
                        data[j].namaBank.toString(),
                      ),
                    ),
                  ),
                );
              }

              menuButtons.add(
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Atur properti ini agar widget sejajar di atas
                    children: rowItems,
                  ),
                ),
              );
            }

            return Column(
              children: menuButtons,
            );
          }),
        )

      ],
    );


  }

  // Widget buildCircularMenuList() {
  //   return Obx(
  //         () => GridView.builder(
  //       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //         maxCrossAxisExtent: 120.0,
  //         crossAxisSpacing: 8.0,
  //         mainAxisSpacing: 8.0,
  //       ),
  //       itemCount: jsonData.length,
  //       itemBuilder: (context, index) {
  //         return GestureDetector(
  //           onTap: () {
  //             if (jsonData[index]["data"])
  //               print('Menu ${index + 1} tapped');
  //           },
  //           child: menuButtonTopup(jsonData[index]["icons"] as String, jsonData[index]["nama_bank"]),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget menuButtonTopup(String imagePath, String jdulText) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(imagePath),
                ),
              ),
              SizedBox(height: 1),
            ],
          ),
        ),
        Text(
          jdulText,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final RxList<Map<String, dynamic>> jsonData = <Map<String, dynamic>>[].obs;

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.18.33/api/payment/top%20up'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedData = json.decode(response.body);
        jsonData.assignAll(List<Map<String, dynamic>>.from(parsedData['data']));
      } else {
        throw Exception('Gagal memuat data dari API');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // profilDashboard(User),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),'Promo'),
          ),
        ),
        PromoBanner(),
        ElevatedButton(
          onPressed: fetchData,
          child: Text('Ambil Data API'),
        ),
        Expanded(
          child: buildCircularMenuList(),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),'Top Up/Beli'),
          ),
        ),
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
    );
  }

  Widget buildCircularMenuList() {
    return Obx(
          () => GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120.0,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: jsonData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (jsonData[index]["data"]) print('Menu ${index + 1} tapped');
            },
            child: menuButtonTopup(jsonData[index]["icons"] as String, jsonData[index]["nama_bank"]),
          );
        },
      ),
    );
  }

  Widget menuButtonTopup(String imagePath, String jdulText) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Image(
                  image: NetworkImage(imagePath),
                ),
              ),
              SizedBox(height: 1),
            ],
          ),
        ),
        Text(
          jdulText,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


