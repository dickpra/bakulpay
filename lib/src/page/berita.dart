import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  PageController _pageController = PageController();
  List<String> newsList = [
    "Berita 1",
    "Berita 2",
    "Berita 3",
    // Tambahkan berita lainnya
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200, // Tinggi banner
        child: PageView.builder(
          controller: _pageController,
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Center(
                  child: Text(
                    newsList[index],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            );
          },
        ),
      );
  }
}
