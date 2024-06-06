import 'package:flutter/material.dart';
import 'package:news_app/components/categories_container.dart';

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
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoriesContainer(
                    categoryName: 'Gneral',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CategoriesContainer(
                    categoryName: 'Ary News',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CategoriesContainer(
                    categoryName: 'BBC News',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CategoriesContainer(
                    categoryName: 'Jazeera',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CategoriesContainer(
                    categoryName: 'Ansa News',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
