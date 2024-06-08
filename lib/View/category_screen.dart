import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Model/categories_news_model.dart';
import 'package:news_app/View%20Model/view_news_repo.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String selectedCategory = 'General';
  final categoryList = [
    'General',
    'Technology',
    'Health',
    'Education',
    'Sports'
  ];

  @override
  Widget build(BuildContext context) {
    NewsViewModel newsViewModel = NewsViewModel();

    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = categoryList[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedCategory == categoryList[index]
                            ? const Color.fromARGB(255, 40, 216, 46)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: width * .3,
                      height: height * 0.08,
                      child: Center(
                        child: Text(
                          categoryList[index],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<CatergoriesModel>(
              future:
                  newsViewModel.fetchcategoriesNewsHeadlines(selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error occurred'),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.articles![index];
                        DateTime.parse(data.publishedAt.toString());
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  width: width * .4,
                                  height: height * .17,
                                  imageUrl: data.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        data.content.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        data.description.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        data.source!.name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No Data Available"),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
