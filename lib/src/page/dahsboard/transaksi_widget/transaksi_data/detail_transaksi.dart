import 'package:bakulpay/src/model/history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataTransaksiPage extends StatelessWidget {
  late final model_history data;

  DataTransaksiPage(this.data);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Transaksi', style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold
          )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.blue,
                    border: Border.all(
                      color: Colors.grey
                    )
                  ),
                  child: Column(
                    children: [
                      if(data.type == 'Top-Up')
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Text('Rp.${data.totalPembayaran.toString()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                      ),
                      if(data.type == 'Withdraw')
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: Text('\$${data.totalPembayaran.toString()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                          ),
                        ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Text(data.status.toString(), style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: getStatusColor(data.status.toString()),)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Text(data.tanggal.toString(), style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 10),

              /// Kode Transaksi
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Kode Transaksi')),
                        Expanded(
                          child: Text(data.idPembayaran.toString(),style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Produk')),
                        Expanded(
                          child: Text(data.product.toString(),style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                      ],
                    ),
                  ],
                ),
              ),
          
              // SizedBox(height: 10,),
              /// Detail Produk
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider()),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Text('Detail Produk', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Jenis Produk')),
                        Expanded(
                          child: Text('${data.product.toString()} ${data.type.toString()}',style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Rek/email')),
                        Expanded(
                          child: Text(data.rekClient.toString(),style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Harga Satuan')),
                        Expanded(
                          child: Text(data.priceRate.toString(),style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Potongan diskon')),
                        Expanded(
                          child: Text('null',style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Total Tagihan')),
                        if(data.type == 'Top-Up')
                        Expanded(
                          child: Text('\$${data.jumlah.toString()}',style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                        if(data.type == 'Withdraw')
                        Expanded(
                          child: Text('Rp.${data.jumlah.toString()}',style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Total Diterima',style: TextStyle(
                            fontWeight: FontWeight.bold
                        ))),
                        if(data.type == 'Withdraw')
                        Expanded(
                          child: Text('\$${data.totalPembayaran.toString()}',style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                        if(data.type == 'Top-Up')
                          Expanded(
                            child: Text('Rp.${data.totalPembayaran.toString()}',style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                      ],
                    ),
                  ],
                ),
              ),


              /// Rincian Pembayaran
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider()),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Text('Rincian Pembayaran', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Metode Pembayaran')),
                        Expanded(
                          child: Text(data.namaBank.toString(),style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Status Pembayaran')),
                        Expanded(
                          child: Text(
                            data.status.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getStatusColor(data.status.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(child: Divider()),
                      ],
                    ),
                  ],
                ),
              ),


              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider()),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Text('Bukti Pembayaran', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(child: Text('Metode Pembayaran')),
                    //     Expanded(
                    //       child: Text('Skrill',style: TextStyle(
                    //           fontWeight: FontWeight.bold
                    //       )),
                    //     ),
                    //   ],
                    // ),
                    Image.network(
                      '${data.buktiPembayaran}',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Text('Error loading image');
                      },
                    ),

                    Row(
                      children: [
                        Expanded(child: Divider()),
                      ],
                    ),
                  ],
                ),
              ),





              // Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         // color: Colors.blue,
              //         border: Border.all(
              //             color: Colors.grey
              //         )
              //     ),
              //     child: Column(
              //       children: [
              //         Align(
              //           alignment: Alignment.topLeft,
              //           child: Padding(
              //             padding: const EdgeInsets.all(3),
              //             child: Text(style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),'Isi Saldo Dari'),
              //           ),
              //         ),
              //         SizedBox(height: 5),
              //         Row(
              //           children: [
              //             Image(image: AssetImage('assets/images/gopay.png')),
              //             SizedBox(width: 10),
              //             Align(
              //               alignment: Alignment.topLeft,
              //               child: Padding(
              //                 padding: EdgeInsets.all(0),
              //                 child: Text(style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,),'Gopay'),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.grey,
              //       )
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(3),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Expanded(
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     // color: Colors.green
              //                   ),
              //                   child: Row(
              //                     children: [
              //                       Icon(Icons.list_alt,color: Colors.blue),
              //                       SizedBox(width: 10),
              //                       Text('Rincian Pesanan',style: TextStyle(
              //                           fontWeight: FontWeight.bold
              //                       )),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 5),
              //           Container(
              //               decoration: BoxDecoration(
              //                 // color: Colors.green
              //               ),
              //               child: Column(
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.all(0),
              //                     child: Row(
              //                       children: [
              //                         Expanded(
              //                           child: Text(
              //                             'Jenis Produk',
              //                             style: TextStyle(fontSize: 16),
              //                           ),
              //                         ),
              //                         Expanded(
              //                           child: Text(
              //                             'Paypal',
              //                             style: TextStyle(fontSize: 16),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(0),
              //                     child: Row(
              //                       children: [
              //                         Expanded(
              //                           child: Text(
              //                             'Email',
              //                             style: TextStyle(fontSize: 16),
              //                           ),
              //                         ),
              //                         Expanded(
              //                           child: Text(
              //                             'Shilanadila123@gmail.com',
              //                             style: TextStyle(fontSize: 14),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(0),
              //                     child: Row(
              //                       children: [
              //                         Expanded(
              //                           child: Text(
              //                             'Jumlah',
              //                             style: TextStyle(fontSize: 16),
              //                           ),
              //                         ),
              //                         Expanded(
              //                           child: Text(
              //                             '\$10',
              //                             style: TextStyle(fontSize: 16),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(0),
              //                     child: Row(
              //                       children: [
              //                         Expanded(
              //                           child: Text(
              //                             'Total Pembayaran',
              //                             style: TextStyle(fontSize: 16),
              //                           ),
              //                         ),
              //                         Expanded(
              //                           child: Text(
              //                             'Rp40.000',
              //                             style: TextStyle(fontSize: 16),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               )
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildContainer()  {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey
          ),
          // color: Colors.red
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.blue
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.list_alt,color: Colors.blue),
                                      SizedBox(width: 10),
                                      Text('Total Pesanan',style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                              decoration: BoxDecoration(
                                // color: Colors.green
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Jenis Produk'),
                                      Text('Paypal',style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Email Paypal'),
                                      Text('',style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Jumlah'),
                                      Text('',style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Harga Satuan'),
                                      Text('Rp.',style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      )),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
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

}


