import 'package:flutter/material.dart';

class ExampleWidget extends StatelessWidget {
  final bool isHidden;

  ExampleWidget({required this.isHidden});

  @override
  Widget build(BuildContext context) {
    // Jika isHidden true, widget tidak ditampilkan
    if (isHidden) {
      return SizedBox.shrink(); // Widget kosong
    }

    // Jika isHidden false, widget ditampilkan
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(16.0),
      child: Text('Ini adalah widget yang ditampilkan'),
    );
  }
}


class MyApp22 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool conditionToHide = false; // Ganti kondisi sesuai kebutuhan

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hide Widget Example'),
        ),
        body: Column(
          children: [
            ExampleWidget(isHidden: conditionToHide),
            // Widget lainnya
          ],
        ),
      ),
    );
  }
}
