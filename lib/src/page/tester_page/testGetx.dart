import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryItem {
  final int id;
  final int userId;
  final String idPembayaran;
  final String tanggal;
  final String rekClient;
  final String jumlah;
  final String totalPembayaran;
  final String namaBank;
  final String nama;
  final String buktiPembayaran;
  final String buktiTf;
  final String product;
  final String namaBlockchain;
  final String priceRate;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String type;

  HistoryItem({
    required this.id,
    required this.userId,
    required this.idPembayaran,
    required this.tanggal,
    required this.rekClient,
    required this.jumlah,
    required this.totalPembayaran,
    required this.namaBank,
    required this.nama,
    required this.buktiPembayaran,
    required this.buktiTf,
    required this.product,
    required this.namaBlockchain,
    required this.priceRate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      idPembayaran: json['id_pembayaran'] ?? '',
      tanggal: json['tanggal'] ?? '',
      rekClient: json['rek_client'] ?? '',
      jumlah: json['jumlah'] ?? '',
      totalPembayaran: json['total_pembayaran'] ?? '',
      namaBank: json['nama_bank'] ?? '',
      nama: json['nama'] ?? '',
      buktiPembayaran: json['bukti_pembayaran'] ?? '',
      buktiTf: json['bukti_tf'] ?? '',
      product: json['product'] ?? '',
      namaBlockchain: json['nama_blockchain'] ?? '',
      priceRate: json['price_rate'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class MyController extends GetxController {
  ScrollController scrollController = ScrollController();
  List<dynamic> historyItems = [];
  int page = 1;
  bool isLoading = false;

  void loadData() async {
    isLoading = true;
    update();

    final String apiUrl = 'https://bakulpay.jjtech.my.id/api/history/2/?page=$page&limit=12';
    final String token = '165|OPIUg4NeNyBCmIKIo0AUo4TMFzN7z0ALZswhn4pGc85418ba';

    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<HistoryItem> newItems = (data['data']['data'] as List<dynamic>)
          .map((dynamic item) => HistoryItem.fromJson(item))
          .toList();

      if (newItems.isEmpty) {
        print('kontoool$newItems');
        // Tidak ada data baru, matikan animasi refresh
        isLoading = false;
        update();
      } else {
        print('kontoool$newItems');
        historyItems.addAll(newItems);
        page++;
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      update();
      // Handle error
      print('Failed to load data. Error: ${response.statusCode}');
    }
  }
}

class MyAppGetx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePageGetx(),
    );
  }
}

class MyHomePageGetx extends StatefulWidget {
  const MyHomePageGetx({super.key});

  @override
  State<MyHomePageGetx> createState() => _MyHomePageGetxState();
}

class _MyHomePageGetxState extends State<MyHomePageGetx> {
  MyController _myController = Get.put(MyController());
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _myController.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination Scroll Data'),
      ),
      body: GetBuilder<MyController>(
        builder: (_) {
          return SmartRefresher(
            controller: _refreshController,
            enablePullUp: true,
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.loading) {
                  // Menampilkan animasi loading ketika sedang loading
                  body = CircularProgressIndicator();
                } else {
                  // Menampilkan teks sesuai dengan status
                  String text = "Pull up to load more";
                  if (mode == LoadStatus.failed) {
                    text = "Failed to load. Tap to retry.";
                  } else if (mode == LoadStatus.canLoading) {
                    text = "Release to load more";
                  } else if (mode == LoadStatus.noMore) {
                    text = "No more data";
                  }
                  body = Text(text, style: TextStyle(color: Colors.grey));
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            onLoading: () async{
              await Future.delayed(Duration(seconds: 1));
              _myController.loadData();
              _refreshController.loadComplete();
            },
            child: ListView.builder(
              controller: _myController.scrollController,
              itemCount: _myController.historyItems.length + (_myController.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _myController.historyItems.length) {
                  return ListTile(
                    title: Text(_myController.historyItems[index].nama),
                    subtitle: Text('Date: ${_myController.historyItems[index].tanggal}, Status: ${_myController.historyItems[index].status}'),
                  );
                } else {

                }
              },
            ),
          );
        },
      ),
    );
  }
}

