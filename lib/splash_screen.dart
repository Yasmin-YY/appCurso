import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'onboarding_screen.dart';

class SplashScreenFlutter extends StatefulWidget {
  @override
  _SplashScreenFlutterState createState() => _SplashScreenFlutterState();
}

class _SplashScreenFlutterState extends State<SplashScreenFlutter> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(seconds: 2),
          child: Lottie.asset('assets/images/logoanimacaoo.json', width: 150),
        ),
      ),
    );
  }
}
