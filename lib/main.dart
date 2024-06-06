import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/View/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
        backgroundColor: Colors.blue,
      )),
      home: const SplashScreen(),
    );
  }
}
