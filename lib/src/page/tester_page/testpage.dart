import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';




// class HistoryController extends GetxController {
//   var historyData = <Map<String, dynamic>>[].obs;
//   var currentPage = 1.obs;
//   final int perPage = 5;
//
//   late ScrollController scrollController;
//
//   void clearJsonDataTransaksi() {
//     historyData.clear();
//     currentPage.value= 0;
//   }
//
//   final String apiUrl = 'https://bakulpay.jjtech.my.id/api/history/2/';
//   final String token = 'Bearer 165|OPIUg4NeNyBCmIKIo0AUo4TMFzN7z0ALZswhn4pGc85418ba';
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchData();
//     scrollController = ScrollController();
//     scrollController.addListener(() {
//       if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//         fetchData();
//       }
//     });
//   }
//
//   Future<void> fetchData() async {
//     final url = '$apiUrl?page=${currentPage.value}&limit=$perPage';
//     final response = await http.get(
//       Uri.parse(url),
//       headers: {'Authorization': token},
//     );
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final List<dynamic> historyList = responseData['data']['data'];
//
//       historyData.addAll(historyList.cast<Map<String, dynamic>>());
//       currentPage.value++;
//     } else {
//       throw Exception('Failed to load history');
//     }
//   }
// }
//
//
// class HistoryList extends StatefulWidget {
//   const HistoryList({super.key});
//
//   @override
//   State<HistoryList> createState() => _HistoryListState();
// }
//
// class _HistoryListState extends State<HistoryList> {
//
//
//   final HistoryController historyController = Get.put(HistoryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('History List'),
//       ),
//       body: Obx(
//             () {
//           return ListView.builder(
//             itemCount: historyController.historyData.length + 1,
//             itemBuilder: (BuildContext context, int index) {
//               if (index == historyController.historyData.length) {
//                 // Loading indicator jika user scroll ke bawah
//                 return CircularProgressIndicator();
//               } else {
//                 final history = historyController.historyData[index];
//                 return ListTile(
//                   title: Text('ID Pembayaran: ${history['bukti_pembayaran']}'),
//                   // Tambahkan widget lain sesuai kebutuhan
//                 );
//               }
//             },
//             controller: historyController.scrollController,
//           );
//         },
//       ),
//     );
//   }
// }




class HistoryController extends GetxController {
  var historyData = <Map<String, dynamic>>[].obs;
  var currentPage = 1.obs;
  var isLoading = false.obs; // Menambahkan state untuk menandai apakah sedang dalam proses memuat
  final int perPage = 7;
  void clearJsonData() {
    historyData.clear();
    currentPage.value = 1;
  }
  // late ScrollController scrollController;
  ScrollController scrollController = ScrollController();

  final String apiUrl = 'https://bakulpay.jjtech.my.id/api/history/2/';
  final String token = 'Bearer 165|OPIUg4NeNyBCmIKIo0AUo4TMFzN7z0ALZswhn4pGc85418ba';

  @override
  void onInit() {
    super.onInit();
    fetchData();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLoading.value) {
          // Memastikan bahwa tidak ada proses memuat sebelumnya
          fetchDataWithDelay();
        }
      }
    });
  }

  Future<void> fetchData() async {
    isLoading.value = true; // Menandai bahwa sedang dalam proses memuat
    final url = '$apiUrl?page=${currentPage.value}&limit=$perPage';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> historyList = responseData['data']['data'];

      historyData.addAll(historyList.cast<Map<String, dynamic>>());
      currentPage.value++;
    } else {
      throw Exception('Failed to load history');
    }

    isLoading.value = false; // Menandai bahwa proses memuat telah selesai
  }

  Future<void> fetchDataWithDelay() async {
    await Future.delayed(Duration(seconds: 1)); // Delay selama 1 detik
    await fetchData(); // Memanggil fungsi fetchData setelah delay
  }
}

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  void initState() {
    super.initState();
    historyController.clearJsonData();
    historyController.fetchData();
  }

  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History List'),
      ),
      body: Obx(
            () {
          return ListView.builder(
            itemCount: historyController.historyData.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == historyController.historyData.length) {
                // Loading indicator jika user scroll ke bawah
                return CircularProgressIndicator();
              } else {
                final history = historyController.historyData[index];
                return ListTile(
                  title: Text('ID Pembayaran: ${history['jumlah']}'),
                  // Tambahkan widget lain sesuai kebutuhan
                );
              }
            },
            controller: historyController.scrollController,
          );
        },
      ),
    );
  }
}



class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}


class MyHomePage22 extends StatefulWidget {
  @override
  _MyHomePage22State createState() => _MyHomePage22State();
}

class _MyHomePage22State extends State<MyHomePage22> {
  late ScrollController _scrollController;
  late List<Post> _posts;
  late int _page;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _posts = [];
    _page = 1;
    _loadData();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=$_page'));

    if (response.statusCode == 200) {
      final List<Post> newPosts = (json.decode(response.body) as List<dynamic>)
          .map((dynamic item) => Post.fromJson(item))
          .toList();

      setState(() {
        _posts.addAll(newPosts);
        _page++;
      });
    }
  }
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination Scroll Data'),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _posts.length + 1,
          itemBuilder: (context, index) {
            if (index < _posts.length) {
              return ListTile(
                title: Text(_posts[index].title),
                subtitle: Text(_posts[index].body),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}



