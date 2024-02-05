import 'package:flutter/material.dart';
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
  final dynamic namaBlockchain;
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


class MyHomePage33 extends StatefulWidget {
  @override
  _MyHomePage33State createState() => _MyHomePage33State();
}

class _MyHomePage33State extends State<MyHomePage33> {
  late ScrollController _scrollController;
  late List<HistoryItem> _historyItems;
  late int _page;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _historyItems = [];
    _page = 1;
    _loadData();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !_isLoading) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'https://bakulpay.jjtech.my.id/api/history/2/?page=$_page&limit=11';
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
        // Tidak ada data baru, matikan animasi refresh
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _historyItems.addAll(newItems);
          _page++;
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      print('Failed to load data. Error: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination Scroll Data'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _historyItems.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _historyItems.length) {
            return ListTile(
              title: Text(_historyItems[index].nama),
              subtitle: Text('Date: ${_historyItems[index].tanggal}, Status: ${_historyItems[index].status}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
