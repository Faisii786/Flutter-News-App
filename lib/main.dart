import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/View/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
          appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
        backgroundColor: Colors.blue,
      )),
      home: const SplashScreen(),
    );
  }
}
