import 'package:flutter/material.dart';

class CategoriesOfNews extends StatefulWidget {
  const CategoriesOfNews({super.key});

  @override
  State<CategoriesOfNews> createState() => _CategoriesOfNewsState();
}

class _CategoriesOfNewsState extends State<CategoriesOfNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
    );
  }
}
