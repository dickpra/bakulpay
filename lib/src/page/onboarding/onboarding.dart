import 'dart:async';

import 'package:bakulpay/src/page/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login/register_page.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize page controller

    // Automatic scroll behaviour
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  final List<Widget> _onboardingPages = [
    OnboardingPage("", "Selamat datang di Aplikasi Top Up dan Withdraw kami, sebuah platform yang didedikasikan untuk memberikan pengalaman transaksi keuangan yang aman, andal, dan efisien.", "assets/images/LOGO.png", "assets/images/onbord1.png" ),
    OnboardingPage("", "Dengan standar keamanan data terkini, kami berkomitmen untuk melindungi informasi pribadi Anda dan menyediakan lingkungan transaksi yang aman dan terpercaya.", "assets/images/LOGO.png", "assets/images/onbord2.png"),
    OnboardingPage("Page 3", "Selamat menggunakan Aplikasi Top Up dan Withdraw kami. Kami berharap dapat memberikan Anda pengalaman transaksi yang menyenangkan, efisien, dan aman.", "assets/images/LOGO.png", "assets/images/onbord3.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingPages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _onboardingPages[index];
            },
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < _onboardingPages.length - 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                   } else {
                    // Navigate to the next screen or perform any action
                    // when onboarding is completed
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  }
                },
                child: Text(_currentPage < _onboardingPages.length - 1 ? 'Next' : 'Get Started'),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(33.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    _onboardingPages.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(
                        isActive: index == _currentPage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         if (_currentPage < _onboardingPages.length + 1) {
          //           _pageController.previousPage(
          //             duration: Duration(milliseconds: 500),
          //             curve: Curves.ease,
          //           );
          //         } else {
          //           // Navigate to the next screen or perform any action
          //           // when onboarding is completed
          //         }
          //       },
          //       child: Text(_currentPage < _onboardingPages.length - 1
          //           ? '<-'
          //           : 'Get Started'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String imagePath2;

  OnboardingPage(this.title, this.description, this.imagePath, this.imagePath2);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 200,
          height: 200,
        ),
        SizedBox(height: 20),
        Image.asset(
          imagePath2,
          width: 200,
          height: 200,
        ),
        // SizedBox(height: 10),
        // Text(
        //   title,
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(color:Colors.blue, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.white,
        border: isActive ? null : Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

