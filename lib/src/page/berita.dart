import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsController extends GetxController {
  final newsList = <Article>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  Future<void> fetchNews() async {
    isLoading.value = true;

    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=Cryptocurrency&sortBy=publishedAt&apiKey=85490456598f494584fcfe1e14a53987'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List articles = jsonResponse['articles'];
      newsList.assignAll(
          articles.map((article) => Article.fromJson(article)).toList());
    } else {
      throw Exception('Failed to load news');
    }

    isLoading.value = false;
  }
}

class NewsPage extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('News')),
      body: Container(
        color: Colors.white,
        child: Obx(() {
          if (newsController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return PageView.builder(
              itemCount: newsController.newsList.length,
              itemBuilder: (context, index) {
                final article = newsController.newsList[index];
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      _launchURL(article.url!);
                      print('${article.url}');
                    },
                    child: Card(
                      margin: EdgeInsets.all(9),
                      color: Colors.white,
                      elevation: 5.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          article.urlToImage != null
                              ? Image.network(
                            // height: MediaQuery.of(context).size.height * 0.5, // atur tinggi sesuai kebutuhan
                            // width: MediaQuery.of(context).size.width * 0.8,
                            // width: MediaQuery.of(context).size.height,
                            article.urlToImage!,
                            // scale: 5,
                          )
                              : Container(),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              article.title ?? 'No Title',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: article.urlToImage != null
                                ? Text(
                              article.description ?? 'No Description',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                                : Text(
                              article.description ?? 'No Description',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Article {
  final String? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source']['name'] ?? 'Unknown Source',
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

