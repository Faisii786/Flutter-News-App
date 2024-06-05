import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:news_app/View/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.to(() => const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/splash_pic.jpg",
            fit: BoxFit.cover,
            width: width * 1,
            height: height * .5,
          ),
          SizedBox(
            height: height * 0.04,
          ),
          const Text(
            "News App",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: height * 0.08,
          ),
          const SpinKitChasingDots(
            color: Colors.blue,
            size: 30.0,
          )
        ],
      ),
    );
  }
}
