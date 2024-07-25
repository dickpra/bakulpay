import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatelessWidget {
  final Uri _url = Uri.parse('https://wa.me/6283833744725');

  Future<void> _launchURL() async {
    if (await launchUrl(_url)) {
      throw Exception('Could not launch');
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
        backgroundColor: Color(0xFF5444A4),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.gif'), // Ganti dengan path gambar latar belakang Anda
            fit: BoxFit.cover, // Menyesuaikan gambar agar sesuai dengan ukuran container
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/catyu.gif'), // Ganti dengan path gambar profil Anda
              ),
              SizedBox(height: 20),
              Text(
                'NIKONIKONIKONIKO',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Warna teks sesuai dengan latar belakang
                ),
              ),
              SizedBox(height: 10),
              Text(
                'FLUTTER',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.white, // Warna teks sesuai dengan latar belakang
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Hai Aplikasi Ini dibuat menggunakan FLutter.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white), // Warna teks sesuai dengan latar belakang
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _launchURL();
                },
                child: Text('Hubungi Saya'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}