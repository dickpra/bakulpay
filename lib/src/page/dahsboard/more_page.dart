import 'package:bakulpay/src/page/topUp/topup_page.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class morePage extends StatelessWidget {
  const morePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          title: Text('Semua Kategori'),
          centerTitle: true,
        ),
      body: Hero(
        tag: 'anjay',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 120),
                      // margin: EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: topupButton("assets/images/payp.png","Paypal",(){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Topup(),
                                    ),
                                  );
                                }),
                              ),
                              Expanded(child: topupButton("assets/images/jasabayar.png","JasaBayar",(){})),
                              Expanded(child: topupButton("assets/images/perfectmoney.png","PerfectMoney",(){})),
                              Expanded(child: topupButton("assets/images/skrill.png","Skrill",(){})),

                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: topupButton("assets/images/nett.png","Pay Owner",(){})),
                              Expanded(child: topupButton("assets/images/visa.png","VCC",(){})),
                              Expanded(child: topupButton("assets/images/usdt.png","USDT",(){})),
                              Expanded(child: topupButton("assets/images/busd.png","BUSD",(){})),


                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: topupButton("assets/images/payeer.png","Payeer",(){})),
                              Spacer(flex: 3),
                              // Expanded(child: Text(''),),
                              // Expanded(child: Text(''),),
                              // Expanded(child: Text(''),),

                            ],
                          ),

                          // SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      )
    ));
  }
}
