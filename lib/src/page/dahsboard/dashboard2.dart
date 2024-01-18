import 'package:bakulpay/src/model/test_model.dart';
import 'package:bakulpay/src/page/berita.dart';
import 'package:bakulpay/src/page/dahsboard/profil_widget/profil_widget.dart';
import 'package:bakulpay/src/page/dahsboard/rate/rate.dart';
import 'package:bakulpay/src/page/dahsboard/transaksi_widget/history.dart';
import 'package:bakulpay/src/page/dahsboard/wd_widget/wdPage.dart';
import 'package:bakulpay/src/service/preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bakulpay/src/controller/controller.dart';
import 'package:bakulpay/src/model/test_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'home_widget/home.dart';


import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    GetAllSync();
  }
  Future<void> _refreshData() async {
    setState(() {
      GetAllSync();
    });
  }

  int _currentIndex = 0;

  final List<Widget> pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(

        decoration: BoxDecoration(
              color: Color(0xFFffa4af),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Business Page'),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('School Page'),
    );
  }
}

class DashboardNew extends StatefulWidget {
  @override
  _DashboardNewState createState() => _DashboardNewState();
}

class _DashboardNewState extends State<DashboardNew> {
  @override
  void initState() {
    super.initState();
    GetAllSync();
  }
  int _currentIndex = 0;

  final List<Widget> pages = [
    HomeTab(),
    SecondTab(),
    ThirdTab(),
    FourthTab(),
    FiftTab(),
  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ return await
      Alert(
        context: context,
        // onWillPopActive: true,
        type: AlertType.warning,
        title: "Warning",
        desc: "Apakah anda ingin keluar Aplikasi?",
        buttons: [
          DialogButton(
            child: Text(
              "Ya",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => SystemNavigator.pop(),
            color: Colors.red,
          ),
          DialogButton(
            child: Text(
              "Tidak",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color.fromRGBO(0, 179, 134, 1.0),
          )
        ],
      ).show()
          ?? false;
        },
      child: Scaffold(
        // backgroundColor: Color(0xFFf67280),
        extendBody: true,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
              // color: Color(0xFFffa4af),
              color: Colors.white,
              borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
            ),
            child: Row(
              children: <Widget>[
                buildNavItem(0, 'assets/images/menuikon/hm.png', 'Home'),
                buildNavItem(1, 'assets/images/menuikon/wd.png', 'Withdraw'),
                buildNavItem(2, 'assets/images/menuikon/tx.png', 'Transaksi'),
                buildNavItem(3, 'assets/images/menuikon/rate.png', 'Rate'),
                buildNavItem(4, 'assets/images/menuikon/pp.png', 'Profil'),
              ],
            ),
          ),
        ),
        body: pages[_currentIndex],
      ),
    );
  }

  Widget buildNavItem(int index, String icon, String label) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(icon, color: _currentIndex == index ? Color(0xff37398B) : Colors.grey),
              Text(
                label,
                style: TextStyle(
                  color: _currentIndex == index ? Color(0xff37398B) : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    GetAllSync();
  }
  Future<void> _refreshData() async {
    setState(() {
      GetAllSync();
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // profilDashboard(user: widget.user.displayName),
              ProfilDashboard(),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),'Promo'),
                ),
              ),
              PromoBanner(),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),'Top Up/Beli'),
                ),
              ),
              BeliTopup(),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),'Berita Terkini'),
                ),
              ),
              Container(
                // height: 180,
                child: NewsPage(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: WithdrawPage(),
        ),
      ),
    );
  }
}

class ThirdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.blue,
        ),
        child: transaksi(),
      ),
    );
  }
}

class FourthTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: ratePage(),
        ),
      ),
    );
  }
}
class FiftTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: profilWidget(),
        ),
      ),
    );
  }
}



