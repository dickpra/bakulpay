import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/history_model.dart';
import 'package:bakulpay/src/model/rate_model.dart';
import 'package:bakulpay/src/page/dahsboard/transaksi_widget/history.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';


class MyPaginatedListView extends StatefulWidget {
  @override
  _MyPaginatedListViewState createState() => _MyPaginatedListViewState();
}

class _MyPaginatedListViewState extends State<MyPaginatedListView> {
  final PagingController<int, model_history> _pagingController =
  PagingController(firstPageKey: 0);
  PayController payController = Get.put(PayController());

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    // Simulasikan pengambilan data dari sumber eksternal (API, database, dll.)
    // Gantilah dengan logika pengambilan data sesuai dengan kebutuhan Anda.
    final data = payController.jsonDataTransaksi;
    final List<model_history> newData = data;
    final isLastPage = newData.length > 1;
    // Simulasikan waktu tunggu pengambilan data.
    await Future.delayed(Duration(seconds: 1));

    if (isLastPage.isNull) {
      _pagingController.appendLastPage(data);
    } else {
      final nextPageKey = pageKey + 100;
      _pagingController.appendPage(newData, nextPageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PaginatedListView Example'),
      ),
      body: PagedListView<int, model_history>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<model_history>(
          itemBuilder: (context, item, index) {
            return Listdata(item,index);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
  Container Listdata(model_history data, index) {
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
                  if(data.product == 'Paypal')
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
                    ),if(data.product == 'Perfect Money')
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
                    ),if(data.product == 'Pay Owner' || data.product == 'Payooner')
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
                    ),if(data.product == 'Skrill')
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
                    ),if(data.product == 'VCC')
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
                    ),if(data.product == 'Payeer')
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
                    ),if(data.product == 'USDT')
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
                    ),if(data.product == 'BUSD')
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
                      Text('${data.type}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                      SizedBox(height: 5),
                      Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),'${data.product}'),
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
                      color: getStatusColor(data.status.toString()),
                    ),
                    child: Center(
                      child: Text(
                        '${data.status}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  if(data.type == 'Top-Up' || data.type == 'TopUp' || data.type == 'Top Up')
                    Text('Rp.${data.totalPembayaran}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                  if(data.type == 'Withdraw')
                    Text('\$${data.totalPembayaran}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
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
                  child: Text('${data.tanggal}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,))),
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
}

