import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Model/categories_news_model.dart';
import 'package:news_app/Model/headlines_model.dart';
import 'package:news_app/View%20Model/view_news_repo.dart';
import 'package:news_app/View/category_screen.dart';
import 'package:news_app/View/news_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum FilterList { bbcNews, buisnessNews, aljazeeraNews }

class _HomePageState extends State<HomePage> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenue;

  String newsName = 'bbc-news';

  String generalNews = 'General';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(
              () => const CategoriesScreen(),
              transition: Transition.fadeIn,
            );
          },
          icon: Image.asset(
            "images/category_icon.png",
            width: width * 0.05,
          ),
        ),
        title: const Text(
          'News',
        ),
        actions: [
          PopupMenuButton(
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  newsName = 'bbc-news';
                } else if (FilterList.buisnessNews.name == item.name) {
                  newsName = 'business-insider';
                } else if (FilterList.aljazeeraNews.name == item.name) {
                  newsName = 'al-jazeera-english';
                }

                setState(() {
                  selectedMenue = item;
                });
              },
              initialValue: selectedMenue,
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews, child: Text("BBC News")),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.buisnessNews,
                        child: Text("Business News")),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.aljazeeraNews,
                        child: Text("Al Jazeera News")),
                  ]),
        ],
      ),
      body: Column(
        children: [
          // fetch bbc news
          Expanded(
            child: FutureBuilder<NewsHeadlinesModel>(
              future: newsViewModel.fetchNewsHeadlines(newsName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitFadingCircle(
                    color: Colors.blue,
                    size: 40.0,
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error occurred'),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        final article = snapshot.data!.articles![index];
                        DateTime dateTime =
                            DateTime.parse(article.publishedAt.toString());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  width: width * 0.75,
                                  height: height * 0.6,
                                ),
                              ),
                              Positioned(
                                top: height * .2,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => NewsDetailedPage(
                                          articles: article,
                                        ),
                                        transition: Transition.fadeIn,
                                      );
                                    },
                                    child: Container(
                                      width: width * 0.7,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            article.title ?? 'No Title',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            article.description ??
                                                'No Description',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  article.source!.name ??
                                                      'No Description',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${dateTime.month.toString()}"
                                                  '/'
                                                  "${dateTime.day.toString()}"
                                                  '/'
                                                  "${dateTime.year.toString()}",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }
                return const Center(
                  child: Text("No Data Available"),
                );
              },
            ),
          ),

          Container(
            height: height * .3,
            child: FutureBuilder<CatergoriesModel>(
              future: newsViewModel.fetchcategoriesNewsHeadlines(generalNews),
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
                              horizontal: 10, vertical: 8),
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
