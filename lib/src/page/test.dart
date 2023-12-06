import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// class MyApiWidget extends StatefulWidget {
//   @override
//   _MyApiWidgetState createState() => _MyApiWidgetState();
// }
//
// class _MyApiWidgetState extends State<MyApiWidget> {
//   List<Map<String, dynamic>> jsonData = [];
//
//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse('http://192.168.18.33/api/payment/top%20up'));
//
//     if (response.statusCode == 200) {
//       // Jika permintaan berhasil, parse response JSON
//       final Map<String, dynamic> parsedData = json.decode(response.body);
//       setState(() {
//         jsonData = List<Map<String, dynamic>>.from(parsedData['data']);
//       });
//     } else {
//       // Jika permintaan gagal, lempar exception
//       throw Exception('Gagal memuat data dari API');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contoh API Flutter'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               fetchData();
//             },
//             child: Text('Ambil Data API'),
//           ),
//           Expanded(
//             child: buildMenuList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildMenuList() {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 120.0,
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
//       ),
//       itemCount: jsonData.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             // Handle menu item tap
//             if(jsonData[index]["icons"])
//             print('Menu ${index + 1} tapped');
//           },
//           child: Card(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.network(jsonData[index]["icons"] as String, height: 40),
//                 SizedBox(height: 8),
//                 Text(jsonData[index]["nama_bank"] as String),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class MyApiWidget extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Contoh API Flutter'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: fetchData,
            child: Text('Ambil Data API'),
          ),
          Expanded(
            child: buildCircularMenuList(),
          ),
        ],
      ),
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

