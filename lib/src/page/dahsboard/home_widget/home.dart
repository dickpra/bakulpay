import 'dart:async';
import 'dart:ffi';

import 'package:bakulpay/src/page/dahsboard/more_page.dart';
import 'package:bakulpay/src/page/dahsboard/transaksi_widget/transaksi.dart';
import 'package:bakulpay/src/page/test.dart';
import 'package:bakulpay/src/page/topUp/topup_page.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class profilDashboard extends StatelessWidget {
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
                Text(
                  'Shila2207!',
                  style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold), // Tambahkan warna teks
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: 20, // Sesuaikan lebar sesuai kebutuhan
          // ),
          Align(
            child: Container(
              padding: EdgeInsets.only(left: 80),
              decoration: BoxDecoration(
                // color: Colors.grey,
              ),
              width: MediaQuery.of(context).size.width * 0.5, // Gunakan ukuran relatif untuk gambar
              child: Image.asset('assets/images/LOGO.png'),
            ),
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
            color: Colors.grey.withOpacity(0.5), // Warna bayangan
            spreadRadius: 2, // Seberapa luas bayangan menyebar
            blurRadius: 5, // Seberapa kabur bayangan
            offset: Offset(0, 3), // Perpindahan bayangan secara horizontal dan vertikal
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


class beliTopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 120),
                // margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  // color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: topupButton("assets/images/payp.png","Paypal",(){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => topupPaypal(),
                              ),
                            );
                          }),
                        ),
                        Expanded(child: topupButton("assets/images/jasabayar.png","JasaBayar",(){})),
                        Expanded(child: topupButton("assets/images/perfectmoney.png","PerfectMoney",(){})),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: topupButton("assets/images/nett.png","Pay Owner",(){})),
                        Expanded(child: topupButton("assets/images/skrill.png","Skrill",(){})),
                        Expanded(
                          child: topupButton("assets/images/more_horiz.png","More",(){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => wasuuu(),
                              ),
                            );
                          }),
                        ),

                      ],
                    ),
                    SizedBox(height: 20),


                  ],
                ),
              ),
            ),
          ],
        )

      ],
    );
  }
}

