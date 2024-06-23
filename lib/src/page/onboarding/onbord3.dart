import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen3 extends StatefulWidget {
  const OnboardingScreen3({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen3> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  Widget _buildImage(String assetName, [double width = 300]) {
    return Image.asset('assets/images/$assetName', width: width);
  }
  Widget _buildImage2(String assetName, [double width = 100]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0, color: Colors.blue);

    const pageDecoration = PageDecoration(

      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "",
          body:
          "Selamat datang di Aplikasi Top Up dan Withdraw kami, sebuah platform yang didedikasikan untuk memberikan pengalaman transaksi keuangan yang aman, andal, dan efisien.",
          image: _buildImage('3d-illustration-wallet-with-coins-credit-cards 2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '',
          body:
          "A lounge for skaters around the world to connect and share their love of skateboarding.",
          image: _buildImage('onboarding-screen-image-2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body:
          " Share pictures of your latest tricks and challenges with other users, find out about upcoming events, or ask them for tips.",
          image: _buildImage('onboarding-screen-image-3.png'),
          footer: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: ElevatedButton(
              onPressed: () {
                print("Clicked Get Started Button");
              },
              child: const Text(
                'GET STARTED',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(55),
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      showSkipButton: false,
      showDoneButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: const Text('Back',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      next: const Text('Next',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(8.0, 8.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(15.0, 5.0),
        activeColor: Colors.black,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}